#!/usr/bin/env cwl-runner
# Generated from: bash ./scripts/togoid_convert.sh ./test/workflow_test/foldseek_result_hit_species.txt uniprot,ensembl_protein,ensembl_transcript,ensembl_gene,hgnc,hgnc_symbol foldseek_hit_species_togoid_convert.tsv
class: CommandLineTool
cwlVersion: v1.2
label: "togoid convert"
doc: |
  togoid convert using TOGO ID API
  see article: doi:10.1093/bioinformatics/btac491
  ID conversion process UniProt ID - Ensembl Protein ID - Ensembl Transcript ID - Ensembl Gene ID - HGNC Gene Symbol


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
    label: "togoid convert script"
    doc: "togoid convert shell script. using TOGO ID API."
    type: File
    default:
      class: File
      location: ../scripts/togoid_convert_v2.sh
  - id: id_convert_file
    label: "id convert file"
    doc: "target id file. default: UniProt ID list."
    type: File
    default:
      class: File
      location: ../test/oryza_sativa_test_202509/foldseek_result_hit_species.txt
  - id: route_dataset
    label: "route dataset"
    doc: "route dataset for togoid convert."
    type: string
    default: "uniprot,ensembl_protein,ensembl_transcript,ensembl_gene,hgnc,hgnc_symbol"
  - id: output_file_name
    type: string
    label: "output file name (togoid convert)"
    doc: "output file name for togoid convert script."
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