#!/usr/bin/env cwl-runner
# Generated from: foldseek databases CATH50 cath50 tmp --threads 16
class: CommandLineTool
cwlVersion: v1.2
baseCommand: [foldseek, databases]
arguments:
  - $(inputs.database)
  - $(inputs.index_name)
  - $(runtime.tmpdir)
  - --threads
  - $(inputs.threads)
inputs:
  - id: database
    type: string
    default: "CATH50"
  - id: index_name
    type: string
    default: "cath50"
  - id: threads
    type: int
    default: 16
outputs:
  - id: all-for-debugging
    type:
      type: array
      items:
        - File
        - Directory
    outputBinding:
      glob: "*"
# hints:
#   - class: DockerRequirement
#     dockerPull: quay.io/biocontainers/foldseek:9.427df8a--pl5321hb365157_1