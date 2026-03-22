#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
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
    default:
      class: File
      location: ../scripts/run_water_v2.sh

  - id: foldseek_extract_tsv
    type: File
    format: edam:format_3475

  - id: split_fasta_query_species_dir
    type: Directory

  - id: split_fasta_hit_species_dir
    type: Directory

  - id: result_water_dir_name
    type: string
    default: "result_water"
  - id: query_col_num
    type: int
    default: 1
  - id: target_col_num
    type: int
    default: 2

outputs:
  - id: water_result_dir
    type: Directory
    outputBinding:
      glob: "$(inputs.result_water_dir_name)"

  - id: water_result_file
    type: File[]
    outputBinding:
      glob: "$(inputs.result_water_dir_name)/*.water"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.5.7--4

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/