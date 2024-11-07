#!/usr/bin/env cwl-runner
# Generated from: python3 ./scripts/extract_target_species.py --input ./out/rice_up/foldseek_output_uniprot_up_all_evalue01.tsv --target_species 9606 --output foldseek_rice_up_9606.tsv
class: CommandLineTool
cwlVersion: v1.2
baseCommand: [python3]
arguments:
  - $(inputs.extract_target_species_py)
  - --input
  - $(inputs.input_file)
  - --target_species
  - $(inputs.target_species)
  - --output
  - $(inputs.output_file_name)
inputs:
  - id: extract_target_species_py
    type: File
    default:
      class: File
      location: file:///workspaces/004_foldseek/scripts/extract_target_species.py
  - id: input_file
    type: File
    format: edam:format_3475
    default:
      class: File
      format: edam:format_3475
      location: file:///workspaces/004_foldseek/out/rice_up/foldseek_output_uniprot_up_all_evalue01.tsv
  - id: target_species
    type: int
    default: 9606
  - id: output_file_name
    type: string
    default: "foldseek_rice_up_9606.tsv"
outputs:
  - id: output_extract_file
    type: File
    format: edam:format_3475
    outputBinding:
      glob: "$(inputs.output_file_name)"

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/

