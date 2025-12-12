#!/usr/bin/env cwl-runner
# Generated from: foldseek databases Alphafold/Swiss-Prot index_swissprot tmp --threads 16
class: CommandLineTool
cwlVersion: v1.2
label: "foldseek createdb"
doc: "foldseek createdb command process. usage: foldseek createdb <i:directory|.tsv>|<i:PDB|mmCIF[.gz]|tar[.gz]|DB> ... <i:PDB|mmCIF[.gz]|tar|DB> <o:sequenceDB> [options]"

requirements:
  ShellCommandRequirement: {}
  NetworkAccess:
    networkAccess: true

inputs:
  - id: input_structure_files
    label: "Input structure files (tar or directory)"
    doc: |
      Input tar[.gz] file or directory containing PDB/mmCIF files.
      Example: UP000005640_9606_HUMAN_v6.tar from https://ftp.ebi.ac.uk/pub/databases/alphafold/v6/
    type: File
    default:
      class: File
      location: ../index/UP000005640_9606_HUMAN_v6.tar

  - id: index_dir_name
    label: "Index directory name"
    doc: "Index directory name to store the created database"
    type: string
    default: "index_human_proteome"

  - id: index_name
    label: "Index name"
    doc: "Index name to store the created database"
    type: string
    default: "human_proteome_v6"

  - id: input_format
    label: "Input file format"
    doc: |
      Format of input structures:
      0: Auto-detect by extension
      1: PDB
      2: mmCIF
      3: mmJSON
      4: ChemComp
      5: Foldcomp
    type: int
    default: 2  # mmCIF

  - id: write_mapping
    label: "Write mapping file"
    doc: |
      Write _mapping file containing mapping from internal id to taxonomic identifier.
      0: disabled, 1: enabled
    type: int
    default: 1  # Enable for taxonomy support

  - id: threads
    label: "Number of threads"
    doc: "Number of CPU-cores used"
    type: int
    default: 16

stdout: foldseek_createdb.log

arguments:
  - shellQuote: false
    valueFrom: |
      # Exit on error and print commands
      set -eux

      # Create the output directory
      mkdir -p "$(inputs.index_dir_name)"

      # Change into the output directory
      cd "$(inputs.index_dir_name)"
      
      foldseek createdb "$(inputs.input_structure_files.path)" "$(inputs.index_name)" --input-format "$(inputs.input_format)" --write-mapping "$(inputs.write_mapping)" --threads "$(inputs.threads)"

outputs:
  # Capture the log file
  - id: stdout
    type: File
    outputBinding:
      glob: foldseek_createdb.log

  - id: index_dir
    type: Directory
    label: "index directory"
    doc: "index directory"
    outputBinding:
      glob: "$(inputs.index_dir_name)"

  - id: database_main_file
    type: File
    outputBinding:
      glob: "$(inputs.index_dir_name)/$(inputs.index_name)"
    secondaryFiles:
      - _ca
      - _ca.dbtype
      - _ca.index
      - _h
      - _h.dbtype
      - _h.index
      - _mapping
      - _ss
      - _ss.dbtype
      - _ss.index
      # - _taxonomy
      - .dbtype
      - .index
      - .lookup
      - .source


hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldseek:9.427df8a--pl5321h5021889_2