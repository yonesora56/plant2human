#!usr/bin/env python3
# -*- coding: utf-8 -*-


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


def get_af_json(dataframe: pl.DataFrame, target_dir: str):
    """
    Get JSON file from AlphaFoldDB
    """
    pathlib.Path(target_dir).mkdir(parents=True, exist_ok=True)
    setup_logging(target_dir)
    
    for row in dataframe.iter_rows():
        gene_id = row[0]
        uniprot_id = row[1]
        
        json_file_name = pathlib.Path(target_dir) / f"{gene_id}_{uniprot_id}_info.json"
        
        if json_file_name.exists():
            message_1 = f"{json_file_name} already exists"
            print(message_1)
            logging.info(message_1)
            continue
        
        request_url = f"https://alphafold.ebi.ac.uk/api/prediction/{uniprot_id}"
        
        try:
            response = requests.get(request_url, headers={"Accept": "application/json"}, timeout=30)
            response.raise_for_status()
            
            if response.text:
                data = json.loads(response.text) # parse json
                if isinstance(data, list) and len(data) > 0:
                    message_2 = f"AlphaFold ID {uniprot_id} found in AlphaFold"
                    print(message_2)
                    logging.info(message_2)
                    with open(json_file_name, 'w') as f:
                        json.dump(data[0], f, indent=4)
                else:
                    message_3 = f"AlphaFold ID {uniprot_id} not found in AlphaFold"
                    print(message_3)
                    logging.warning(message_3)
            else:
                message_4 = f"Empty response for AlphaFold ID {uniprot_id}"
                print(message_4)
                logging.warning(message_4)
        except requests.exceptions.RequestException as e:
            message_5 = f"Request failed: {e}"
            print(message_5)
            logging.error(message_5)
            message_6 = f"AlphaFold ID {uniprot_id} not found in AlphaFold"
            print(message_6)
            logging.warning(message_6)
        time.sleep(5)

  
def main():
    parser = argparse.ArgumentParser(description="Retrieve AlphaFold JSON data and save to directory.")
    parser.add_argument("--file", type=str, help="Path to the CSV file containing the data.")
    parser.add_argument("--target_dir", type=str, help="Directory to save the JSON files.")
    
    args = parser.parse_args()
    
    dataframe = pl.read_csv(args.file, separator="\t")
    get_af_json(dataframe, args.target_dir)

if __name__ == "__main__":
    main()