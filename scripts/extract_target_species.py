#!usr/bin/env python3
"""
Extract target species from foldseek result file
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
                        help="Target species")
    parser.add_argument("--output",
                        help="Output file name")
    args = parser.parse_args()

    foldseek_result_df = pl.read_csv(
        args.input,
        separator='\t'
    ).with_columns(
        (pl.col("query").str.extract(r"AF-(.*?)-F1", 1).alias("query")), # "?" means non-greedy
        (pl.col("target").str.extract(r"AF-(.*?)-F1", 1).alias("target"))
    ).rename(
        {
            "query" : "UniProt Accession",
            "target" : "foldseek hit"
        }
    ).filter(
        (pl.col("taxid").is_in(args.target_species))
    )

    foldseek_result_df.write_csv(
        args.output,
        separator='\t'
    )

    print(f"Number of rows: {foldseek_result_df.height}")
    print(
        f"Target species {args.target_species} \n"
        f"extracted from {args.input} \n"
        f"and saved to {args.output}"
    )

if __name__ == "__main__":
    main()
