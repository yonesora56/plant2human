#!/usr/bin/env cwl-runner
# Generated from: makeblastdb -in ./data/uniprotkb_rice_all_240820.fasta -out ./data/index_uniprot_rice/uniprotkb_rice_all_240820 -dbtype prot -hash_index -parse_seqids
class: CommandLineTool
cwlVersion: v1.2
label: "makeblastdb command for blastdbcmd execution"

requirements:
  ShellCommandRequirement: {}
  WorkReuse:
    enableReuse: true

inputs:
  - id: index_dir_name
    type: string
    doc: "index directory name"
    default: index_uniprot_rice
  - id: input_fasta_file
    type: File
    format: edam:format_1929
    doc: "input fasta file"
    default:
      class: File
      format: edam:format_1929
      location: ../Data/Data_uniprot/FASTA_for_index/uniprotkb_rice_all_240820.fasta
  # - id: output_index_name
  #   type: string
  #   doc: "output index name"
  #   default: uniprotkb_rice_all_240820
  # - id: dbtype
  #   type: string
  #   doc: "database type"
  #   default: "prot"

arguments:
  - shellQuote: false
    valueFrom: |
      mkdir -p $(inputs.index_dir_name)
      makeblastdb -in $(inputs.input_fasta_file.path) -out $(inputs.index_dir_name)/$(inputs.input_fasta_file.basename) -dbtype prot -hash_index -parse_seqids
      touch $(inputs.index_dir_name)/$(inputs.input_fasta_file.basename) # create empty file

outputs:
  - id: index_dir
    type: Directory
    outputBinding:
      glob: "$(inputs.index_dir_name)"
  - id: index_file
    type: File
    outputBinding:
      glob: "$(inputs.index_dir_name)/$(inputs.input_fasta_file.basename)"
    secondaryFiles:
      - .pdb
      - .phd
      - .phi
      - .phr
      - .pin
      - .pjs
      - .pog
      - .pos
      - .pot
      - .psq
      - .ptf
      - .pto

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast:2.16.0--hc155240_2

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/