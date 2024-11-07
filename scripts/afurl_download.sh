#!/bin/bash

json_dir=$1
output_dir=$2

if [ -z "$json_dir" ] || [ -z "$output_dir" ]; then
  echo "Usage: $0 <json_directory> <output_directory>"
  exit 1
fi

find "$json_dir" -type f -name "*.json" | while read -r json_file; do
  cif_url=$(jq -r '.cifUrl' "$json_file")
  
  if [ "$cif_url" != "null" ]; then
    output_file="$output_dir/$(basename "$cif_url")"
    if [ -f "$output_file" ]; then
      echo "File $output_file already exists. Skipping download."
    else
      echo "Downloading $cif_url"
      curl -o "$output_file" "$cif_url"
    fi
  fi
done