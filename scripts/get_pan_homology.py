#!usr/bin/env python3
# -*- coding: utf-8 -*-


import glob
import requests
import json
import polars as pl
import time
import argparse
import logging
import pathlib
from datetime import datetime


def setup_logging(target_dir: str):
    """
    Set up logging to a file in the target directory with the current date.
    """
    log_filename = pathlib.Path(target_dir) / f"{datetime.now().strftime('%Y%m%d')}_log.txt"
    logging.basicConfig(
        filename=log_filename,
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )


def get_pan_homology(dataframe: pl.DataFrame, query_taxon: str, target_taxon: int, result_dir: str, no_homology_file: str):
    """
    Get pan-homology data from Ensembl and save as JSON files.
    """
    pathlib.Path(result_dir).mkdir(parents=True, exist_ok=True)
    setup_logging(result_dir)
    
    # no homology gene id information
    no_homology_file_path = pathlib.Path(result_dir) / no_homology_file
    if no_homology_file_path.exists():
        with open(no_homology_file_path, "r") as f:
            no_homology_genes = set(f.read().splitlines())
    else:
        no_homology_genes = set()

    for row in dataframe.iter_rows():
        gene_id = row[0]
        json_file_name = pathlib.Path(result_dir) / f'{gene_id}_pan_homology_{target_taxon}.json'
        
        
        if json_file_name.exists():
            message1 = f"{json_file_name} already exists"
            print(message1)
            logging.info(message1)
            continue
        
        
        if gene_id in no_homology_genes:
            message2 = f"No pan-homology information found for {gene_id} (previously recorded)"
            print(message2)
            logging.info(message2)
            continue
        
        # example url: https://rest.ensembl.org/homology/id/oryza_sativa/Os01g0136200?compara=pan_homology&content-type=application/json;target_taxon=9606
        request_url = (
            f"https://rest.ensembl.org/homology/id/{query_taxon}/{gene_id}?"
            f"compara=pan_homology&content-type=application/json;target_taxon={target_taxon}"
        )

        try:
            response = requests.get(request_url, headers={"Accept": "application/json"}, timeout=30)
            response.raise_for_status()

            if response.status_code == 200:
                data = json.loads(response.text)
                if data.get("data") and any(d.get("homologies") for d in data["data"]):
                    with open(json_file_name, "w") as f:
                        json.dump(data, f, indent=4)
                    message3 = f"Saved {json_file_name}"
                    print(message3)
                    logging.info(message3)
                else: # e.g. {data:[{id: "Os01g0136200", homologies:[]}]}
                    no_homology_genes.add(gene_id) # add gene_id to the text file
                    message4 = f"No homology information found for {gene_id}"
                    print(message4)
                    logging.info(message4)
            else:
                message5 = f"Failed to fetch data for {gene_id}"
                print(message5)
                logging.error(message5)
        except requests.exceptions.RequestException as e:
            message6 = f"Request failed: {e}"
            print(message6)
            logging.error(message6)
        finally:
            time.sleep(5)
    
    # write no pan-homology information gene id 
    no_homology_df = pl.DataFrame({"From": list(no_homology_genes)})
    no_homology_df.write_csv(no_homology_file_path, separator="\t")


def process_json_files(result_dir: str, output_file: str):
    """
    Process JSON files in the result directory and return a dataframe.
    """
    json_files = glob.glob(str(pathlib.Path(result_dir) / "*.json"))
    
    dataframe = []
    
    for file in json_files:
        df = pl.read_json(file).explode("data").unnest("data").rename({"id": "From"}).explode(
            "homologies"
        ).unnest("homologies").unnest("source").rename(
            {
                "perc_pos": "source_perc_pos",
                "perc_id": "source_perc_id",
                "cigar_line": "source_cigar_line",
                "protein_id": "source_protein_id",
                "taxon_id": "source_taxon_id",
                "align_seq": "source_align_seq",
                "id": "source_id",
                "species": "source_species"
            }
        ).unnest("target").rename(
            {
                "perc_pos": "target_perc_pos",
                "perc_id": "target_perc_id",
                "cigar_line": "target_cigar_line",
                "protein_id": "target_protein_id",
                "taxon_id": "target_taxon_id",
                "align_seq": "target_align_seq",
                "id": "target_id",
                "species": "target_species"
            }
        )
        # add data to dataframe
        dataframe.append(df)
    
        
    combined_df = pl.concat(dataframe, how="diagonal_relaxed").sort(
        ["From"], descending=False
    ).select(
        [
            "From",
            "method_link_type",
            "type",
            #"taxonomy_level"
            "source_id",
            "target_id",
            "source_protein_id",
            "target_protein_id",
            "source_perc_pos",
            "target_perc_pos",
            "source_perc_id",
            "target_perc_id"
            # "source_align_seq",
            # "target_align_seq",
            # "source_cigar_line",
            # "target_cigar_line",
            # "dn_ds",
            # "source_taxon_id",
            # "target_taxon_id",
            # "source_species",
            # "target_species",
        ]
    ).sort(
        ["From", "source_perc_id"], descending=[False, False]
    )

    combined_df.write_csv(
        pathlib.Path(result_dir) / output_file,
        separator="\t",
    )
 

def main():
    parser = argparse.ArgumentParser(description="Retrieve Ensembl pan-homology data and save to directory.")
    parser.add_argument("--file", type=str, help="Path to the TSV file containing the data.")
    parser.add_argument("--query_taxon_name", type=str, help="Query taxon ID for pan-homology.")
    parser.add_argument("--target_taxon_id", type=int, help="Target taxon ID for pan-homology.")
    parser.add_argument("--result_dir", type=str, help="Directory to save the JSON files.")
    parser.add_argument("--no_homology_file", type=str, help="File to save gene IDs with no homology information.", default="no_homology_genes.txt")
    parser.add_argument("--output_json_concat_file", type=str, help="File to save the output data.", default="pan_homology.tsv")
    
    args = parser.parse_args()
    
    dataframe = pl.read_csv(args.file, separator="\t").select(pl.col("From")).sort(pl.col("From")).unique()
    get_pan_homology(dataframe, args.query_taxon_name, args.target_taxon_id, args.result_dir, args.no_homology_file)
    process_json_files(args.result_dir, args.output_json_concat_file)
    

if __name__ == "__main__":
    main()