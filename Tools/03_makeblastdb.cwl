#!/usr/bin/env cwl-runner
# Generated from: makeblastdb -in ./data/uniprotkb_rice_all_240820.fasta -out ./data/index_uniprot_rice/uniprotkb_rice_all_240820 -dbtype prot -hash_index -parse_seqids
class: CommandLineTool
cwlVersion: v1.2
label: "makeblastdb command for blastdbcmd execution"
doc: |
  This tool is used to create a blast database from a fasta file.
  This process assumes that the query, target, and both files are data that are predicted in AlphaFold DB.
  The input fasta file is available from https://ftp.ebi.ac.uk/pub/databases/alphafold/sequences.fasta

requirements:
  ShellCommandRequirement: {}
  WorkReuse:
    enableReuse: true

inputs:
  - id: index_dir_name
    type: string
    label: "index directory name"
    doc: "index directory name"
    default: index_uniprot_afdb_all_sequences
  - id: input_fasta_file
    type: File
    # format: edam:format_1929
    label: "input fasta file"
    doc: "input fasta file"
    default:
      class: File
      # format: edam:format_1929
      location: ../index/afdb_all_sequences_v6.fasta

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

  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast:2.17.0--h66d330f_0

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/