#!/usr/bin/env cwl-runner
# Generated from: bash ./scripts/run_water.sh ./test/rice_up/foldseek_rice_up_9606.tsv ./test/rice_up/split_fasta_query_species/ ./test/rice_up/split_fasta_hit_species/ result_water 1 2
class: CommandLineTool
cwlVersion: v1.2
label: "water command for water execution"
doc: "custom script for water execution. Before executing, make sure the split fasta files are already created by 16_seqretsplit.cwl"

baseCommand: [bash]
arguments:
  - $(inputs.run_water_script)
  - $(inputs.foldseek_extract_tsv)
  - $(inputs.split_fasta_query_species_dir)
  - $(inputs.split_fasta_hit_species_dir)
  - $(inputs.result_water_dir_name)
  - $(inputs.query_col_num)
  - $(inputs.target_col_num)
inputs:
  - id: run_water_script
    type: File
    label: "run water script"
    doc: "run water script (default: ../scripts/run_water.sh)"
    default:
      class: File
      location: ../scripts/run_water.sh
  - id: foldseek_extract_tsv
    type: File
    format: edam:format_3475
    label: "foldseek extract tsv file"
    doc: "foldseek extract tsv file (default: ../test/workflow_test/foldseek_rice_up_9606.tsv)"
    default:
      class: File
      format: edam:format_3475
      location: ../test/workflow_test/foldseek_rice_up_9606.tsv
  - id: split_fasta_query_species_dir
    type: Directory
    label: "split fasta query species directory"
    doc: "split fasta query species directory (default: ../test/workflow_test/split_fasta_query_species/)"
    default:
      class: Directory
      location: ../test/workflow_test/split_fasta_query_species/
  - id: split_fasta_hit_species_dir
    type: Directory
    label: "split fasta hit species directory"
    doc: "split fasta hit species directory (default: ../test/workflow_test/split_fasta_hit_species/)"
    default:
      class: Directory
      location: ../test/workflow_test/split_fasta_hit_species/
  - id: result_water_dir_name
    type: string
    label: "result water directory name"
    doc: "result water directory name (default: result_water)"
    default: "result_water"
  - id: query_col_num
    type: int
    label: "query column number"
    doc: "query column number (default: 1)"
    default: 1
  - id: target_col_num
    type: int
    label: "target column number"
    doc: "target column number (default: 2)"
    default: 2
outputs:
  - id: water_result_dir
    type: Directory
    label: "result water directory"
    doc: "result water directory"
    outputBinding:
      glob: "$(inputs.result_water_dir_name)"
  - id: water_result_file
    type: File[]
    label: "result water files"
    doc: "result water files"
    outputBinding:
      glob: "$(inputs.result_water_dir_name)/*.water"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.5.7--4

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/