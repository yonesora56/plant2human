#!/usr/bin/env cwl-runner
# Generated from: seqretsplit -sequence blastdbcmd_result_query_species.fasta -sformat1 fasta -sprotein1 -osdirectory2 split_fasta_query_species -auto
class: CommandLineTool
cwlVersion: v1.2
# baseCommand: [seqretsplit]

requirements:
  ShellCommandRequirement: {}

inputs:
  - id: sequence
    type: File
    doc: "sequence file"
    format: edam:format_1332
    default:
      class: File
      format: edam:format_1332
      location: file:///workspaces/004_foldseek/test/workflow_test/blastdbcmd_result_query_species.fasta
  # - id: sformat1
  #   type: string
  #   doc: "sequence format"
  #   default: "fasta"
  - id: output_dir_name
    type: string
    doc: "output directory name"
    default: "split_fasta_query_species"

arguments:
  - shellQuote: false
    valueFrom: |
      mkdir -p $(inputs.output_dir_name)
      seqretsplit -sequence $(inputs.sequence.path) -sformat1 fasta -sprotein1 -osdirectory2 $(inputs.output_dir_name) -auto

outputs:
  - id: output_dir
    type: Directory
    outputBinding:
      glob: "$(inputs.output_dir_name)"
  - id: split_fasta_files
    type: File[]
    outputBinding:
      glob: "$(inputs.output_dir_name)/*.fasta"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.5.7--4

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/