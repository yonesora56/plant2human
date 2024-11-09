#!/usr/bin/env cwl-runner
# Generated from: foldseek databases CATH50 cath50 tmp --threads 16
class: CommandLineTool
cwlVersion: v1.2

requirements:
  ShellCommandRequirement: {}
  NetworkAccess:
    networkAccess: true
inputs:
  - id: database
    label: "Database name"
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

arguments:
  - shellQuote: false
    valueFrom: |
      mkdir -p $(inputs.index_dir_name)
      foldseek databases $(inputs.database) $(inputs.index_dir_name)/$(inputs.index_name) $(runtime.tmpdir) --threads $(inputs.threads)

outputs:
  - id: all-for-debugging
    type:
      type: array
      items:
        - File
        - Directory
    outputBinding:
      glob: "*"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldseek:9.427df8a--pl5321hb365157_1