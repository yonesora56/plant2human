#!/usr/bin/env cwl-runner
# Generated from: bash ./scripts/run_water.sh ./test/rice_up/foldseek_rice_up_9606.tsv ./test/rice_up/split_fasta_query_species/ ./test/rice_up/split_fasta_hit_species/ result_water 1 2
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
      location: file:///workspaces/004_foldseek/scripts/run_water.sh
  - id: foldseek_extract_tsv
    type: File
    default:
      class: File
      location: file:///workspaces/004_foldseek/test/workflow_test/foldseek_rice_up_9606.tsv
  - id: split_fasta_query_species_dir
    type: Directory
    default:
      class: Directory
      location: file:///workspaces/004_foldseek/test/workflow_test/split_fasta_query_species/
  - id: split_fasta_hit_species_dir
    type: Directory
    default:
      class: Directory
      location: file:///workspaces/004_foldseek/test/workflow_test/split_fasta_hit_species/
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