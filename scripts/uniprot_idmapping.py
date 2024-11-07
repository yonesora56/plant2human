#!usr/bin/env python3

# -*- coding: utf-8 -*-
import time
import argparse
from typing import List, Tuple
import polars as pl
from unipressed import IdMappingClient


def chunk_list(lst: List, chunk_size: int) -> List[List]:
    """Split a list into chunks"""
    return [lst[i:i + chunk_size] for i in range(0, len(lst), chunk_size)]


def batch_id_mapping(
    from_db: str,
    to_db: str,
    ids: List[str],
    chunk_size: int = 100
) -> Tuple[pl.DataFrame, List[str]]:
    """function for batch id mapping"""
    all_results = []
    all_unmapped = []
    chunked_ids = chunk_list(ids, chunk_size)

    for i, chunk in enumerate(chunked_ids):
        print(f"Processing chunk {i+1}/{len(chunked_ids)}...")
        # create request and run
        request = IdMappingClient.submit(source=from_db, dest=to_db, ids=chunk)
        # process results
        chunk_results = list(request.each_result())
        mapped_results = [{"from": item["from"], "to": item["to"]} for item in chunk_results]
        all_results.extend(mapped_results)

        # record unmapped ids
        mapped_ids = set(item["from"] for item in mapped_results)
        unmapped = [id for id in chunk if id not in mapped_ids]
        all_unmapped.extend(unmapped)

        # avoid API rate limit
        time.sleep(3)

    # convert results to DataFrame
    final_df = pl.DataFrame(all_results)
    return final_df, all_unmapped


def main():
    """main function"""
    parser = argparse.ArgumentParser(description="Map gene IDs from Ensembl to UniProtKB")
    parser.add_argument("--input",
                        help="Input TSV file containing gene IDs")
    parser.add_argument("--output",
                        default="mapped_ids.tsv",
                        help="Output file name for unmapped gene IDs")
    parser.add_argument("--column",
                        default="From",
                        help="Column name containing gene IDs")
    parser.add_argument("--unmapped_list",
                        default="unmapped_ids.txt",
                        help="Output file name for unmapped gene IDs")
    parser.add_argument("--from_db",
                        default="Ensembl_Genomes",
                        help="Database to map from")
    parser.add_argument("--to_db",
                        default="UniProtKB",
                        help="Database to map to")
    args = parser.parse_args()

    # Read gene IDs from input TSV file
    gene_ids = pl.read_csv(
        args.input,
        separator="\t"
    ).get_column(
        args.column # column name containing gene IDs
    ).to_list()

    # Perform ID mapping
    result_df, unmapped_ids = batch_id_mapping(
        args.from_db,
        args.to_db,
        gene_ids
    )

    # Save mapped IDs to TSV
    result_df.rename(
        {
            "from": args.column,
            "to": "UniProt Accession"
        }
    ).unique().sort(by=args.column).write_csv(
        args.output,
        separator="\t"
    )
    print(f"Mapped IDs saved to {args.output}")

    # Save unmapped IDs to specified output file as TSV
    pl.DataFrame(
        {
            "Unmapped_ID": unmapped_ids
        }
    ).unique().write_csv(
        args.unmapped_list,
        separator="\t"
    )
    print(f"Unmapped IDs saved to {args.unmapped_list}")

if __name__ == "__main__":
    main()
