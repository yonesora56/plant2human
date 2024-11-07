#!/usr/bin/env cwl-runner
# Generated from: python3 ../scripts/uniprot_search_afurl.py --file ../Data/Data_uniprot/HN5_genes_up_rice_concat.tsv --target_dir ../rice_up_afinfo
class: CommandLineTool
cwlVersion: v1.2
doc: Search AlphaFoldDB and download JSON files.
requirements:
  NetworkAccess:
    networkAccess: true

baseCommand: [python3]
arguments:
  - $(inputs.uniprot_search_afurl_py)
  - --file
  - $(inputs.file)
  - --target_dir
  - $(inputs.target_dir)

inputs:
  - id: uniprot_search_afurl_py
    type: File
    doc: "original python script for retrieving AlphaFoldDB JSON files."
    default:
      class: File
      location: file:///workspaces/004_foldseek/scripts/uniprot_search_afurl.py

  - id: file
    type: File
    doc: "input TSV file. Use TSV files with 'uniprot_idmapping.py' and 'uniprot_remapping.py' processing."
    default:
      class: File
      location: file:///workspaces/004_foldseek/Data/Data_uniprot/HN5_genes_up_rice_concat.tsv

  - id: target_dir
    type: Directory
    doc: "target directory to save JSON files"
    default:
      class: Directory
      location: file:///workspaces/004_foldseek/out/rice_up_afinfo

outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"

