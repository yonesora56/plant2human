#!/usr/bin/env cwl-runner
# Generated from: seqretsplit -sequence blastdbcmd_result_query_species.fasta -sformat1 fasta -sprotein1 -osdirectory2 split_fasta_query_species -auto
class: CommandLineTool
cwlVersion: v1.2
label: "seqretsplit command for split fasta file"
doc: "seqretsplit command for split fasta file which is created by 15_blastdbcmd.cwl. Before executing, make sure the blastdbcmd result file is already created by 15_blastdbcmd.cwl"

requirements:
  ShellCommandRequirement: {}

inputs:
  - id: sequence
    type: File
    label: "sequence file"
    doc: "sequence file (default: ../test/workflow_test/blastdbcmd_result_query_species.fasta)"
    format: edam:format_1929
    default:
      class: File
      format: edam:format_1929
      location: ../test/workflow_test/blastdbcmd_result_query_species.fasta
  # - id: sformat1
  #   type: string
  #   doc: "sequence format"
  #   default: "fasta"
  - id: output_dir_name
    type: string
    label: "output directory name"
    doc: "output directory name (default: split_fasta_query_species)"
    default: "split_fasta_query_species"

arguments:
  - shellQuote: false
    valueFrom: |
      mkdir -p $(inputs.output_dir_name)
      seqretsplit -sequence $(inputs.sequence.path) -sformat1 fasta -sprotein1 -osdirectory2 $(inputs.output_dir_name) -auto

outputs:
  - id: output_dir
    type: Directory
    label: "output directory"
    doc: "output directory"
    outputBinding:
      glob: "$(inputs.output_dir_name)"
  - id: split_fasta_files
    type: File[]
    label: "split fasta files"
    doc: "split fasta files"
    outputBinding:
      glob: "$(inputs.output_dir_name)/*.fasta"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.5.7--4

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/