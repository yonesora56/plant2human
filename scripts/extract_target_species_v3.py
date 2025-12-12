#!usr/bin/env python3
"""
Extract target species from foldseek result file.
This process assumes that the query, target, and
both files are data that are predicted in AlphaFold DB.
The output file is in the format of the header in multi-FASTA format 
corresponding to the protein sequence retrieved from AlphaFold DB.

Usage:
python3 extract_target_species_v2.py \
    --input <foldseek result file (e.g. foldseek_result.tsv)> \
    --target_species <target species id (e.g. 9606)> \
    --output <output file (e.g. foldseek_result_9606.tsv)>
"""

# -*- coding: utf-8 -*-
import argparse
import polars as pl

def main():
    """
    extract target species from foldseek result file
    """
    parser = argparse.ArgumentParser(
        description="Extract target species from foldseek result file"
    )
    parser.add_argument("--input",
                        help="Input foldseek result file")
    parser.add_argument("--target_species",
                        type=int,
                        default=9606,
                        help="Target species (default: 9606 for human)")
    parser.add_argument("--output",
                        help="Output file name")
    args = parser.parse_args()

    # Read foldseek result file
    foldseek_result_df = pl.read_csv(
        args.input,
        separator='\t'
    )

    # Check if taxid column exists
    has_taxid = "taxid" in foldseek_result_df.columns

    # Apply transformations
    foldseek_result_df = foldseek_result_df.with_columns(
        # Correspond to the format of the header in multi-FASTA format
        (pl.col("query").str.replace(r"-model_v\d+$", "").str.replace(r"^AF-", "AFDB:AF-").alias("query")), 
        (pl.col("target").str.replace(r"-model_v\d+\.cif$", "").str.replace(r"^AF-", "AFDB:AF-").alias("target"))
    ).rename(
        {
            "query" : "UniProt Accession",
            "target" : "foldseek hit"
        }
    )

    # Filter by taxid only if the column exists
    if has_taxid:
        foldseek_result_df = foldseek_result_df.filter(
            pl.col("taxid") == args.target_species
        )
        print(f"Filtered by taxid = {args.target_species}")
    else:
        print("Warning: 'taxid' column not found. Skipping taxonomy filtering.")
        print("This may occur when using a custom database created with 'foldseek createdb'.")

    # Write output
    foldseek_result_df.write_csv(
        args.output,
        separator='\t'
    )

    print(f"Number of rows: {foldseek_result_df.height}")
    print(
        f"Input: {args.input}\n"
        f"Output: {args.output}"
    )

if __name__ == "__main__":
    main()