#!/usr/bin/env cwl-runner
# Generated from: python3 ./scripts/uniprot_remapping.py --input ./Data/Data_uniprot/HN5_genes_up_rice_unmapping_list.tsv --output ./Data/Data_uniprot/HN5_genes_up_rice_remapping.tsv --unmapped_list ./Data/Data_uniprot/unmapped_ids.txt
class: CommandLineTool
cwlVersion: v1.2
doc: |
  UniProt process 2: python script for re-mapping

requirements:
  NetworkAccess:
    networkAccess: true

baseCommand: [python3]
arguments:
  - $(inputs.uniprot_remapping_py)
  - --input
  - $(inputs.input)
  - --output
  - $(inputs.output_name)
  - --unmapped_list
  - $(inputs.unmapped_list)
inputs:
  - id: uniprot_remapping_py
    type: File
    default:
      class: File
      location: file:///workspaces/004_foldseek/scripts/uniprot_remapping.py
  - id: input
    type: File
    default:
      class: File
      location: file:///workspaces/004_foldseek/Data/Data_uniprot/HN5_genes_up_rice_unmapping_list.tsv
  - id: output_name
    type: string
    default: HN5_genes_up_rice_remapping.tsv
  - id: unmapped_list
    type: string
    default: unmapped_ids.txt
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
#  - id: output
#    type: File
#    outputBinding:
#      glob: "$(inputs.output_name)"
