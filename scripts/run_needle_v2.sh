#!/bin/bash

set -e
set -u
set -o pipefail

if [ "$#" -ne 6 ]; then
    echo "Usage: $0 <input_tsv> <query_fasta_dir> <target_fasta_dir> <output_dir> <uniprot_accession_col> <target_id_col>"
    exit 1
fi

input_tsv="$1"
query_fasta_dir="$2"
target_fasta_dir="$3"
output_dir="$4"
query_col="$5"
target_col="$6"

# create output directory
mkdir -p "$output_dir"

tail -n +2 "$input_tsv" | while IFS=$'\t' read -r line; do
    # get the query and target uniprot accessions and convert to lower case
    # Remove "AFDB:" prefix if present and extract the actual accession ID
    query_uniprot_raw=$(echo "$line" | cut -d $'\t' -f "$query_col")
    target_uniprot_raw=$(echo "$line" | cut -d $'\t' -f "$target_col")
    
    # Remove AFDB: prefix and convert to lowercase
    query_uniprot_accession=$(echo "$query_uniprot_raw" | sed 's/^AFDB://g' | tr '[:upper:]' '[:lower:]')
    target_uniprot_accession=$(echo "$target_uniprot_raw" | sed 's/^AFDB://g' | tr '[:upper:]' '[:lower:]')

    # construct FASTA file paths
    query_fasta_file="$query_fasta_dir/${query_uniprot_accession}.fasta"
    target_fasta_file="$target_fasta_dir/${target_uniprot_accession}.fasta"

    # check if the FASTA files exist
    if [[ ! -f "$query_fasta_file" ]]; then
        echo "FASTA file not found for query: $query_fasta_file, skipping..."
        continue
    fi

    if [[ ! -f "$target_fasta_file" ]]; then
        echo "FASTA file not found for target: $target_fasta_file, skipping..."
        continue
    fi

    # create output file path
    output_file="$output_dir/${query_uniprot_accession}_${target_uniprot_accession}_align.needle"

    # check if the output file already exists
    if [[ -f "$output_file" ]]; then
        echo "Output file already exists: $output_file, skipping..."
        continue
    fi

    # check if the FASTA files exist
    if [[ -f "$query_fasta_file" && -f "$target_fasta_file" ]]; then
        # run needle (default gapopen=10.0, gapextend=0.5)
        needle \
            -asequence "$query_fasta_file" \
            -bsequence "$target_fasta_file" \
            -gapopen 10.0 \
            -gapextend 0.5 \
            -outfile "$output_file" \
            -sprotein1 \
            -sprotein2 \
            -verbose
        echo "Processed: $query_uniprot_accession vs $target_uniprot_accession"
    else
        echo "FASTA file not found for: $query_uniprot_accession ($query_fasta_file) or $target_uniprot_accession ($target_fasta_file)"
    fi
done