#!/usr/bin/env cwl-runner
# awk -F'\t' 'NR > 1 {print $2}' ./data/no_have_ensembl_panhomology_240629.tsv | sort | uniq > uniprot_id.txt
# https://www.commonwl.org/user_guide/topics/parameter-references.html
cwlVersion: v1.2
class: CommandLineTool
label: "extract result"
doc:  |
  extract result from tsv file based on taxonomy id (9606)
  awk -> sort -> uniq -> redirect to uniprot_id.txt

requirements:
  ShellCommandRequirement: {}

inputs:
  - id: tsvfile
    label: "input tsv file"
    type: File
    format: edam:format_3475
    default:
      class: File
      format: edam:format_3475
      location: ../test/workflow_test/foldseek_rice_up_9606.tsv
  - id: column_number
    type: int
    doc: "column number"
    default: 1
  - id: output_file_name
    type: string
    doc: "output file (text file)"
    default: "uniprot_id.txt"

arguments:
  - shellQuote: false 
    valueFrom: |
      # first `$` is for cwl parameter (javascript syntax), second `$` is for awk parameter
      gawk -F'\\t' 'NR > 1 {
        print $$(inputs.column_number)  # Print specified column value
      }' $(inputs.tsvfile.path) | sort | uniq > $(inputs.output_file_name)

outputs:
  - id: output_file
    type: File
    format: edam:format_3475
    outputBinding:
      glob: "$(inputs.output_file_name)"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gawk:4.1.3--0

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/