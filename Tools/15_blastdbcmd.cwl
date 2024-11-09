#!/usr/bin/env cwl-runner
# Generated from: blastdbcmd -db ./data/index/uniprot_rice -entry_batch ./uniprot_id.txt  -out blastdbcmd_result.fasta -logfile blastdbcmd.log
class: CommandLineTool
cwlVersion: v1.2
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
    doc: "database file"
    default:
      class: File
      location: ../Data/Data_uniprot/FASTA_for_index/uniprotkb_rice_all_240820.fasta
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
    default:
      class: File
      location: ../out/rice_up/uniprot_id_rice_up.txt
  - id: retrieve_result_file_name
    type: string
    default: "blastdbcmd_result_rice_up.fasta"
  - id: logfile_name
    type: string
    default: "blastdbcmd_result_rice_up.log"
outputs:
  - id: blastdbcmd_result
    type: File
    format: edam:format_1929
    outputBinding:
      glob: "$(inputs.retrieve_result_file_name)"
  - id: logfile
    type: File
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