#!/usr/bin/env cwl-runner
# Generated from: python3 ./scripts/uniprot_idmapping.py --input ./Data/Data_HN5_genelist_rice_2402/HN5_genes_up_rice.tsv --output ./Data/Data_uniprot/HN5_genes_up_rice_mapping.tsv --unmapped_list ./Data/Data_uniprot/HN5_genes_up_rice_unmapping_list.tsv --from_db Ensembl_Genomes --to_db UniProtKB
class: CommandLineTool
cwlVersion: v1.2
label: "uniprot id mapping process"
doc: |
  UniProt process 1: python script for  UniProt id mapping.
  This script is used to map gene ids to UniProt ids.
  It uses the polars library to read the input file and write the output file.

requirements:
  NetworkAccess:
    networkAccess: true
  WorkReuse:
    enableReuse: false

baseCommand: [python3]
arguments:
  - $(inputs.python_script_for_idmapping)
  - --input
  - $(inputs.input)
  - --output
  - $(inputs.output_name)
  - --column
  - $(inputs.column)
  - --unmapped_list
  - $(inputs.unmapped_list_name)
  - --from_db
  - $(inputs.from_db)
  - --to_db
  - $(inputs.to_db)
inputs:
  - id: python_script_for_idmapping
    type: File
    doc: "python script for id mapping (using polars, unipressed)"
    format: edam:format_3996
    default:
      class: File
      format: edam:format_3996
      location: file:///workspaces/004_foldseek/scripts/uniprot_idmapping.py
  - id: input
    type: File
    doc: "input file for id mapping (gene list, TSV)"
    default:
      class: File
      format: edam:format_3475
      location: file:///workspaces/004_foldseek/test/HN5_genes_up_rice.tsv
  - id: output_name
    type: string
    default: "HN5_genes_up_rice_mapping.tsv"
  - id: column
    type: string
    doc: "Target column name containing gene IDs"
    default: From
  - id: unmapped_list_name
    type: string
    default: "HN5_genes_up_rice_unmapping_list.tsv"
  - id: from_db
    type: string
    default: "Ensembl_Genomes"
  - id: to_db
    type: string
    default: "UniProtKB"
outputs:
  - id: idmapping_result
    type: File
    outputBinding:
      glob: "$(inputs.output_name)"
  - id: unmapped_list
    type: File
    outputBinding:
      glob: "$(inputs.unmapped_list_name)"

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/