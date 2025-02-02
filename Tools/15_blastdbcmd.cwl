#!/usr/bin/env cwl-runner
# Generated from: blastdbcmd -db ./data/index/uniprot_rice -entry_batch ./uniprot_id.txt  -out blastdbcmd_result.fasta -logfile blastdbcmd.log
class: CommandLineTool
cwlVersion: v1.2
label: "blastdbcmd command for blastdbcmd execution"
doc: "blastdbcmd command for blastdbcmd execution. Before executing, make sure all FASTA files (query species and target species) to be indexed are ready"

baseCommand: [blastdbcmd]
arguments:
  - -db
  - $(inputs.index_files)
  - -entry_batch
  - $(inputs.entry_batch)
  - -out
  - $(inputs.retrieve_result_file_name)
  - -logfile
  - $(inputs.logfile_name)
inputs:
  - id: index_files
    type: File
    label: "database file"
    doc: "database file (default: ../test/oryza_sativa_test/index_query_species/uniprotkb_rice_all_240820.fasta)"
    default:
      class: File
      location: ../test/oryza_sativa_test/index_query_species/uniprotkb_rice_all_240820.fasta
    secondaryFiles:
      - .pdb
      - .phd
      - .phi
      - .phr
      - .pin
      - .pjs
      - .pog
      - .pos
      - .pot
      - .psq
      - .ptf
      - .pto
  - id: entry_batch
    type: File
    label: "entry batch file"
    doc: "entry batch file for blastdbcmd execution. Make sure the file is already created by 13_extract_id.cwl"
    default:
      class: File
      location: ../test/oryza_sativa_test/foldseek_result_query_species.txt
  - id: retrieve_result_file_name
    type: string
    label: "retrieve result file name"
    doc: "retrieve result file name (default: blastdbcmd_result_rice_up.fasta)"
    default: "blastdbcmd_result_rice_up.fasta"
  - id: logfile_name
    type: string
    label: "logfile name"
    doc: "logfile name (default: blastdbcmd_result_rice_up.log)"
    default: "blastdbcmd_result_rice_up.log"
outputs:
  - id: blastdbcmd_result
    type: File
    label: "blastdbcmd result file"
    doc: "blastdbcmd result file"
    format: edam:format_1929
    outputBinding:
      glob: "$(inputs.retrieve_result_file_name)"
  - id: logfile
    type: File
    label: "logfile"
    doc: "logfile"
    outputBinding:
      glob: "$(inputs.logfile_name)"

# add successcodes fields for blastdbcmd if ID isn't exist
successCodes: [0,1]

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast:2.16.0--hc155240_2

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/