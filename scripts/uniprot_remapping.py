#!usr/bin/env python3
# -*- coding: utf-8 -*-
import time
import json
import requests
import argparse
import polars as pl
from typing import List


def fetch_uniprot_data(ensembl_ids: List[str]) -> pl.DataFrame:
    results = []

    for id in ensembl_ids:
        print(f"Processing {id}...")
        url = (
            f"https://rest.uniprot.org/uniprotkb/search?"
            f"query=gene:{id}&format=json"
        )
        response = requests.get(url)
        
        if response.status_code == 200:
            data = json.loads(response.text)
            for item in data.get('results', []):
                primary_accession = item.get('primaryAccession', '')
                secondary_accessions = item.get('secondaryAccessions', [])
                all_accessions = [primary_accession] + secondary_accessions
                
                for accession in all_accessions:
                    entry = {
                        "From": id,
                        "UniProt Accession": accession
                    }
                    
                    # Check if the accession is a match for the gene 
                    # (e.g. Os03g0293000 matches OrderedLocusNames)
                    match_found = False
                    for gene in item.get('genes', []):
                        for locus in gene.get('orderedLocusNames', []):
                            if locus.get('value', '') == id:
                                match_found = True
                                break
                        if match_found:
                            break
                    
                    if match_found:
                        results.append(entry)
        else:
            print(f"Error fetching data for {id}: {response.status_code}")
        
        time.sleep(5)

    return pl.DataFrame(results)


def main():
    parser = argparse.ArgumentParser(description="Map gene IDs from Ensembl to UniProtKB")
    parser.add_argument("--input", required=True, help="Input TSV file containing gene IDs")
    parser.add_argument("--output", required=True, default="re-mapped_ids.tsv", help="Output file name for mapped gene IDs")
    parser.add_argument("--unmapped_list", required=True, default="unmapped_ids.txt", help="Output file name for unmapped gene IDs")
    args = parser.parse_args()

    # Read gene IDs from input TSV file
    gene_ids = pl.read_csv(
        args.input,
        separator="\t"
    )
    
    # Check if the input file is empty
    if gene_ids.is_empty():
        print("Input file is empty. Exiting.")
        return
    else:
        print(f"{len(gene_ids)} IDs found in {args.input}")
        gene_ids = gene_ids.get_column(
            "Unmapped_ID"
        ).to_list()

    # Fetch UniProt data
    result_df = fetch_uniprot_data(gene_ids)

    # Save mapped IDs to TSV
    result_df.write_csv(args.output, separator="\t")
    print(f"Mapped IDs saved to {args.output}")

    # Save unmapped IDs to specified output file
    unmapped_ids = [id for id in gene_ids if id not in result_df['From'].to_list()]
    
    if not unmapped_ids:
        print("All IDs are mapped.")
    else:
        with open(args.unmapped_list, "w", encoding="utf-8") as f:
            for id in unmapped_ids:
                f.write(f"{id}\n")
        print(f"Unmapped IDs saved to {args.unmapped_list}")

if __name__ == "__main__":
    main()
