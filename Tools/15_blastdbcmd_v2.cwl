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
    label: "blastdatabase file"
    doc: "blast database file for blastdbcmd"
    default:
      class: File
      location: ../index/index_uniprot_afdb_all_sequences/afdb_all_sequences.fasta
    secondaryFiles:
      - .00.phd
      - .00.phi
      - .00.phr
      - .00.pin
      - .00.pog
      - .00.psq
      - .01.phd
      - .01.phi
      - .01.phr
      - .01.pin
      - .01.pog
      - .01.psq
      - .02.phd
      - .02.phi
      - .02.phr
      - .02.pin
      - .02.pog
      - .02.psq
      - .03.phd
      - .03.phi
      - .03.phr
      - .03.pin
      - .03.pog
      - .03.psq
      - .04.phd
      - .04.phi
      - .04.phr
      - .04.pin
      - .04.pog
      - .04.psq
      - .05.phd
      - .05.phi
      - .05.phr
      - .05.pin
      - .05.pog
      - .05.psq
      - .06.phd
      - .06.phi
      - .06.phr
      - .06.pin
      - .06.pog
      - .06.psq
      - .07.phd
      - .07.phi
      - .07.phr
      - .07.pin
      - .07.pog
      - .07.psq
      - .08.phd
      - .08.phi
      - .08.phr
      - .08.pin
      - .08.pog
      - .08.psq
      - .09.phd
      - .09.phi
      - .09.phr
      - .09.pin
      - .09.pog
      - .09.psq
      - .10.phd
      - .10.phi
      - .10.phr
      - .10.pin
      - .10.pog
      - .10.psq
      - .11.phd
      - .11.phi
      - .11.phr
      - .11.pin
      - .11.pog
      - .11.psq
      - .12.phd
      - .12.phi
      - .12.phr
      - .12.pin
      - .12.pog
      - .12.psq
      - .13.phd
      - .13.phi
      - .13.phr
      - .13.pin
      - .13.pog
      - .13.psq
      - .14.phd
      - .14.phi
      - .14.phr
      - .14.pin
      - .14.pog
      - .14.psq
      - .15.phd
      - .15.phi
      - .15.phr
      - .15.pin
      - .15.pog
      - .15.psq
      - .16.phd
      - .16.phi
      - .16.phr
      - .16.pin
      - .16.pog
      - .16.psq
      - .17.phd
      - .17.phi
      - .17.phr
      - .17.pin
      - .17.pog
      - .17.psq
      - .18.phd
      - .18.phi
      - .18.phr
      - .18.pin
      - .18.pog
      - .18.psq
      - .19.phd
      - .19.phi
      - .19.phr
      - .19.pin
      - .19.pog
      - .19.psq
      - .20.phd
      - .20.phi
      - .20.phr
      - .20.pin
      - .20.pog
      - .20.psq
      - .21.phd
      - .21.phi
      - .21.phr
      - .21.pin
      - .21.pog
      - .21.psq
      - .22.phd
      - .22.phi
      - .22.phr
      - .22.pin
      - .22.pog
      - .22.psq
      - .23.phd
      - .23.phi
      - .23.phr
      - .23.pin
      - .23.pog
      - .23.psq
      - .pal
      - .pdb
      - .pjs
      - .pos
      - .pot
      - .ptf
      - .pto

  - id: entry_batch
    type: File
    label: "entry batch file"
    doc: "entry batch file for blastdbcmd execution. Make sure the file is already created by 13_extract_id.cwl"
    default:
      class: File
      location: ../test/oryza_sativa_test_202509/foldseek_result_query_species.txt
  - id: retrieve_result_file_name
    type: string
    label: "retrieve result file name"
    doc: "retrieve result file name"
    default: "blastdbcmd_result_rice_up.fasta"
  - id: logfile_name
    type: string
    label: "logfile name"
    doc: "logfile name"
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
    dockerPull: quay.io/biocontainers/blast:2.17.0--h66d330f_0

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/