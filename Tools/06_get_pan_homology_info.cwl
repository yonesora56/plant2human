#!/usr/bin/env cwl-runner
# Generated from: python3 ../scripts/get_pan_homology.py --file ../out/foldseek_output_uniprot_up_all_evalue01_parse.tsv --query_taxon_name oryza_sativa --target_taxon_id 9606 --result_dir ../out/rice_up_pan_homology/ --no_homology_file rice_up_no_homology_gene.tsv --output_json_concat_file pan_homology_concat.tsv
class: CommandLineTool
cwlVersion: v1.2

requirements:
  NetworkAccess:
    networkAccess: true

baseCommand: [python3]
arguments:
  - $(inputs.get_pan_homology_py)
  - --file
  - $(inputs.file)
  - --query_taxon_name
  - $(inputs.query_taxon_name)
  - --target_taxon_id
  - $(inputs.target_taxon_id)
  - --result_dir
  - $(inputs.result_dir)
  - --no_homology_file
  - $(inputs.no_homology_file)
  - --output_json_concat_file # add parameter 20240814
  - $(inputs.output_json_concat_file)

inputs:
  - id: get_pan_homology_py
    type: File
    doc: "Original python script to get pan homology information from Ensembl"
    default:
      class: File
      location: file:///workspaces/004_foldseek/scripts/get_pan_homology.py
  - id: file
    type: File
    doc: "Foldseek output file"
    default:
      class: File
      location: file:///workspaces/004_foldseek/out/foldseek_output_uniprot_up_all_evalue01_parse.tsv
  - id: query_taxon_name
    type: string
    doc: "Query taxon name. Please state as 'oryza_sativa'"
    default: oryza_sativa
  - id: target_taxon_id
    type: int
    doc: "Target taxon id"
    default: 9606
  - id: result_dir
    type: Directory
    doc: "Result directory. Create the directory first with mkdir.cwl"
    default:
      class: Directory
      location: file:///workspaces/004_foldseek/out/rice_up_pan_homology
  - id: no_homology_file
    type: string
    doc: "File to store genes without pan homology"
    default: rice_up_no_homology_gene.tsv
  - id: output_json_concat_file
    type: string
    doc: "TSV file to store the pan homology information (concatenated)"
    default: rice_up_pan_homology_concat.tsv
outputs:
  - id: all-for-debugging
    type: File[]
    outputBinding:
      glob: "*"
