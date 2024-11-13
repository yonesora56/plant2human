#!/usr/bin/env cwl-runner
# Generated from: bash ./scripts/run_needle.sh ./test/rice_up/foldseek_rice_up_9606.tsv ./test/rice_up/split_fasta_query_species/ ./test/rice_up/split_fasta_hit_species/ result_needle 1 2
class: CommandLineTool
cwlVersion: v1.2
baseCommand: [bash]
arguments:
  - $(inputs.run_needle_script)
  - $(inputs.foldseek_extract_tsv)
  - $(inputs.split_fasta_query_species_dir)
  - $(inputs.split_fasta_hit_species_dir)
  - $(inputs.result_needle_dir_name)
  - $(inputs.query_col_num)
  - $(inputs.target_col_num)
inputs:
  - id: run_needle_script
    type: File
    default:
      class: File
      location: ../scripts/run_needle.sh
  - id: foldseek_extract_tsv
    type: File
    format: edam:format_3475
    default:
      class: File
      format: edam:format_3475
      location: ../test/oryza_sativa_test/foldseek_os_random_9606.tsv
  - id: split_fasta_query_species_dir
    type: Directory
    default:
      class: Directory
      location: ../test/oryza_sativa_test/split_fasta_query_species/
  - id: split_fasta_hit_species_dir
    type: Directory
    default:
      class: Directory
      location: ../test/oryza_sativa_test/split_fasta_hit_species/
  - id: result_needle_dir_name
    type: string
    default: "result_needle"
  - id: query_col_num
    type: int
    default: 1
  - id: target_col_num
    type: int
    default: 2
outputs:
  - id: needle_result_dir
    type: Directory
    outputBinding:
      glob: "$(inputs.result_needle_dir_name)"
  - id: needle_result_file
    type: File[]
    outputBinding:
      glob: "$(inputs.result_needle_dir_name)/*.needle"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.5.7--4

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/