#!/bin/bash

set -e
set -u
set -o pipefail

USAGE="Usage: $0 <ID text file> <route dataset> <output file name>"

if [ "$#" -ne 3 ]; then
    echo "$USAGE"
    exit 1
fi

ID_FILE="$1"
ROUTE_DATASET="$2"
OUTPUT_FILE_NAME="$3"

# retrieve the number of lines in the ID file
total_lines=$(wc -l < "$ID_FILE")
# calculate the number of files to split the ID file into 1000 lines each
num_files=$(( (total_lines + 999) / 1000 ))

# create an array to store the output file names
output_files=()

for i in $(seq 1 $num_files) ; do # dynamic range
    from=$(((i-1)*1000+1)); 
    to=$((i*1000)); 
    ids=$(sed -n "${from},${to}p" "$ID_FILE" | tr '\n' ',' | sed 's/,$//') ; 
    output_file="${from}-${to}.tsv"
    curl -X POST -d "route=$ROUTE_DATASET&report=full&format=tsv&ids=$ids" https://api.togoid.dbcls.jp/convert > "$output_file"
    output_files+=("$output_file")
done

# concatenate all output files into one final file, keeping only the first header (e.g. "uniprot_id, ensembl_gene_id")
# "{}" is group, not a subshell (subshell is "()")
{
    head -n 1 "${output_files[0]}"
    for file in "${output_files[@]}"; do
        tail -n +2 "$file"
    done
} > "$OUTPUT_FILE_NAME"

# remove the individual split files
rm "${output_files[@]}"