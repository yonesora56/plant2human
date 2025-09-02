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
      location: ../index/afdb_all_sequences.fasta.gz

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
  - id: index_file
    type: File
    outputBinding:
      glob: "$(inputs.index_dir_name)/$(inputs.input_fasta_file.basename)"
    secondaryFiles:
      - .gz.00.phd
      - .gz.00.phi
      - .gz.00.phr
      - .gz.00.pin
      - .gz.00.pog
      - .gz.00.psq
      - .gz.01.phd
      - .gz.01.phi
      - .gz.01.phr
      - .gz.01.pin
      - .gz.01.pog
      - .gz.01.psq
      - .gz.02.phd
      - .gz.02.phi
      - .gz.02.phr
      - .gz.02.pin
      - .gz.02.pog
      - .gz.02.psq
      - .gz.03.phd
      - .gz.03.phi
      - .gz.03.phr
      - .gz.03.pin
      - .gz.03.pog
      - .gz.03.psq
      - .gz.04.phd
      - .gz.04.phi
      - .gz.04.phr
      - .gz.04.pin
      - .gz.04.pog
      - .gz.04.psq
      - .gz.05.phd
      - .gz.05.phi
      - .gz.05.phr
      - .gz.05.pin
      - .gz.05.pog
      - .gz.05.psq
      - .gz.06.phd
      - .gz.06.phi
      - .gz.06.phr
      - .gz.06.pin
      - .gz.06.pog
      - .gz.06.psq
      - .gz.07.phd
      - .gz.07.phi
      - .gz.07.phr
      - .gz.07.pin
      - .gz.07.pog
      - .gz.07.psq
      - .gz.08.phd
      - .gz.08.phi
      - .gz.08.phr
      - .gz.08.pin
      - .gz.08.pog
      - .gz.08.psq
      - .gz.09.phd
      - .gz.09.phi
      - .gz.09.phr
      - .gz.09.pin
      - .gz.09.pog
      - .gz.09.psq
      - .gz.10.phd
      - .gz.10.phi
      - .gz.10.phr
      - .gz.10.pin
      - .gz.10.pog
      - .gz.10.psq
      - .gz.11.phd
      - .gz.11.phi
      - .gz.11.phr
      - .gz.11.pin
      - .gz.11.pog
      - .gz.11.psq
      - .gz.12.phd
      - .gz.12.phi
      - .gz.12.phr
      - .gz.12.pin
      - .gz.12.pog
      - .gz.12.psq
      - .gz.13.phd
      - .gz.13.phi
      - .gz.13.phr
      - .gz.13.pin
      - .gz.13.pog
      - .gz.13.psq
      - .gz.14.phd
      - .gz.14.phi
      - .gz.14.phr
      - .gz.14.pin
      - .gz.14.pog
      - .gz.14.psq
      - .gz.15.phd
      - .gz.15.phi
      - .gz.15.phr
      - .gz.15.pin
      - .gz.15.pog
      - .gz.15.psq
      - .gz.16.phd
      - .gz.16.phi
      - .gz.16.phr
      - .gz.16.pin
      - .gz.16.pog
      - .gz.16.psq
      - .gz.17.phd
      - .gz.17.phi
      - .gz.17.phr
      - .gz.17.pin
      - .gz.17.pog
      - .gz.17.psq
      - .gz.18.phd
      - .gz.18.phi
      - .gz.18.phr
      - .gz.18.pin
      - .gz.18.pog
      - .gz.18.psq
      - .gz.19.phd
      - .gz.19.phi
      - .gz.19.phr
      - .gz.19.pin
      - .gz.19.pog
      - .gz.19.psq
      - .gz.20.phd
      - .gz.20.phi
      - .gz.20.phr
      - .gz.20.pin
      - .gz.20.pog
      - .gz.20.psq
      - .gz.21.phd
      - .gz.21.phi
      - .gz.21.phr
      - .gz.21.pin
      - .gz.21.pog
      - .gz.21.psq
      - .gz.22.phd
      - .gz.22.phi
      - .gz.22.phr
      - .gz.22.pin
      - .gz.22.pog
      - .gz.22.psq
      - .gz.23.phd
      - .gz.23.phi
      - .gz.23.phr
      - .gz.23.pin
      - .gz.23.pog
      - .gz.23.psq
      - .gz.pal
      - .gz.pdb
      - .gz.pjs
      - .gz.pos
      - .gz.pot
      - .gz.ptf
      - .gz.pto

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast:2.17.0--h66d330f_0

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/