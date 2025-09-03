#!/usr/bin/env cwl-runner
# Generated from: makeblastdb -in ./data/uniprotkb_rice_all_240820.fasta -out ./data/index_uniprot_rice/uniprotkb_rice_all_240820 -dbtype prot -hash_index -parse_seqids
class: CommandLineTool
cwlVersion: v1.2
label: "makeblastdb command for blastdbcmd execution"
doc: |
  This tool is used to create a blast database from a fasta file.
  This process assumes that the query, target, and both files are data that are predicted in AlphaFold DB.
  The input fasta file is available from https://ftp.ebi.ac.uk/pub/databases/alphafold/sequences.fasta

requirements:
  ShellCommandRequirement: {}
  WorkReuse:
    enableReuse: true

inputs:
  - id: index_dir_name
    type: string
    label: "index directory name"
    doc: "index directory name"
    default: index_uniprot_afdb_all_sequences
  - id: input_fasta_file
    type: File
    format: edam:format_1929
    label: "input fasta file"
    doc: "input fasta file"
    default:
      class: File
      format: edam:format_1929
      location: ../index/afdb_all_sequences.fasta

arguments:
  - shellQuote: false
    valueFrom: |
      mkdir -p $(inputs.index_dir_name)
      makeblastdb -in $(inputs.input_fasta_file.path) -out $(inputs.index_dir_name)/$(inputs.input_fasta_file.basename) -dbtype prot -hash_index -parse_seqids
      touch $(inputs.index_dir_name)/$(inputs.input_fasta_file.basename) # create empty file

outputs:
  - id: index_dir
    type: Directory
    outputBinding:
      glob: "$(inputs.index_dir_name)"
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
  - id: index_file
    type: File
    outputBinding:
      glob: "$(inputs.index_dir_name)/$(inputs.input_fasta_file.basename)"
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

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast:2.17.0--h66d330f_0

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/