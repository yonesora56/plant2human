#!/usr/bin/env cwl-runner
# Generated from: bash ./scripts/togoid_convert.sh ./test/workflow_test/foldseek_result_hit_species.txt uniprot,ensembl_protein,ensembl_transcript,ensembl_gene,hgnc,hgnc_symbol foldseek_hit_species_togoid_convert.tsv
class: CommandLineTool
cwlVersion: v1.2
baseCommand: [bash]
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: WorkReuse
    enableReuse: false

arguments:
  - $(inputs.togoid_convert_script)
  - $(inputs.id_convert_file)
  - $(inputs.route_dataset)
  - $(inputs.output_file_name)
inputs:
  - id: togoid_convert_script
    type: File
    default:
      class: File
      location: ../scripts/togoid_convert.sh
  - id: id_convert_file
    type: File
    default:
      class: File
      location: ../test/workflow_test/foldseek_result_hit_species.txt
  - id: route_dataset
    type: string
    default: "uniprot,ensembl_protein,ensembl_transcript,ensembl_gene,hgnc,hgnc_symbol"
  - id: output_file_name
    type: string
    default: "foldseek_hit_species_togoid_convert.tsv"
outputs:
  - id: output_file
    type: File
    format: edam:format_3475
    outputBinding:
      glob: "$(inputs.output_file_name)"

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/
