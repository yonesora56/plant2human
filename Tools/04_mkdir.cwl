#!/usr/bin/env cwl-runner
# Generated from: mkdir -p ../out/rice_up_afinfo
class: CommandLineTool
cwlVersion: v1.2
baseCommand: [mkdir, -p]
arguments:
  - -p
  - $(inputs.dir_name)
inputs:
  - id: dir_name
    type: string
    default: rice_up_afinfo
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: $(inputs.dir_name)
