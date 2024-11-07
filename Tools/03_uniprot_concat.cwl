#!/usr/bin/env cwl-runner
# Generated from: python3 ./scripts/uniprot_concat.py --mapped ./Data/Data_uniprot/HN5_genes_up_rice_mapping.tsv --remapped ./Data/Data_uniprot/HN5_genes_up_rice_remapping.tsv --unmapped-list ./Data/Data_uniprot/HN5_genes_up_rice_unmapping_list.tsv --output ./Data/Data_uniprot/HN5_genes_up_rice_concat.tsv
class: CommandLineTool
cwlVersion: v1.2
doc: |
  UniProt process 3: python script for concatenating
  EN: UniProt process 3: python script for concatenating

baseCommand: [python3]
arguments:
  - $(inputs.uniprot_concat_py)
  - --mapped
  - $(inputs.mapped)
  - --remapped
  - $(inputs.remapped)
  - --unmapped-list
  - $(inputs.unmapped_list)
  - --output
  - $(inputs.output_name)
inputs:
  - id: uniprot_concat_py
    type: File
    default:
      class: File
      location: file:///workspaces/004_foldseek/scripts/uniprot_concat.py
  - id: mapped
    type: File
    doc: "UniProt ID mapping file"
    default:
      class: File
      location: file:///workspaces/004_foldseek/Data/Data_uniprot/HN5_genes_up_rice_mapping.tsv
  - id: remapped
    type: File
    doc: "UniProt ID re-mapping file"
    default:
      class: File
      location: file:///workspaces/004_foldseek/Data/Data_uniprot/HN5_genes_up_rice_remapping.tsv
  - id: unmapped_list
    type: File
    doc: "UniProt ID un-mapping list"
    default:
      class: File
      location: file:///workspaces/004_foldseek/Data/Data_uniprot/HN5_genes_up_rice_unmapping_list.tsv
  - id: output_name
    type: string
    doc: "Output file name"
    default: "HN5_genes_up_rice_concat.tsv"
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
