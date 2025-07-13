#!/usr/bin/env cwl-runner
# Generated from: foldseek databases Alphafold/Swiss-Prot index_swissprot tmp --threads 16
class: CommandLineTool
cwlVersion: v1.2
label: "foldseek databases"
doc: "foldseek databases command process. usage: foldseek databases <name> <o:sequenceDB> <tmpDir> [options]"

requirements:
  ShellCommandRequirement: {}
  NetworkAccess:
    networkAccess: true
inputs:
  - id: database
    label: "Database name"
    doc: |
      You can choose from the resources below < confirmed in July 2025 >.
      Alphafold/UniProt, Alphafold/UniProt50-minimal, Alphafold/UniProt50, Alphafold/Proteome, Alphafold/Swiss-Prot, ESMAtlas30, PDB, CATH50, ProstT5
    type: string
    default: "Alphafold/Swiss-Prot"
  - id: index_dir_name
    label: "Index directory name"
    type: string
    default: "index_swissprot"
  - id: index_name
    type: string
    default: "swissprot"
  - id: threads
    type: int
    default: 16

stdout: foldseek_database.log

arguments:
  - shellQuote: false
    valueFrom: |
      # Exit on error and print commands
      set -eux

      # Create the output directory
      mkdir -p "$(inputs.index_dir_name)"

      # Change into the output directory
      cd "$(inputs.index_dir_name)"

      # Create a temporary directory inside the current directory for foldseek to use.
      # This ensures that the temporary directory and the final output directory are on the same filesystem,
      # which can prevent 'mv' errors in containerized environments.
      mkdir temp_db
      foldseek databases "$(inputs.database)" "$(inputs.index_name)" temp_db --threads "$(inputs.threads)"
      rm -rf temp_db

outputs:
  # Capture the log file
  - id: stdout
    type: File
    outputBinding:
      glob: foldseek_database.log

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
      - _taxonomy
      - .dbtype
      - .index
      - .lookup
      - .version


hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldseek:9.427df8a--pl5321h5021889_2