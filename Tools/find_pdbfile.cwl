#!/usr/bin/env cwl-runner
# Generated from: find ./ -type f -name *.pdb > pdb_list.txt
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [find]
arguments:
  - $(inputs.Path)
  - -type
  - $(inputs.type)
  - -name
  - $(inputs.name)
inputs:
  - id: Path
    type: Directory
    doc: "Path to search for PDB files"
    default:
      class: Directory
      location: ./
  - id: type
    type: string
    doc: "Type of file to search for"
    default: f
  - id: name
    type: string
    doc: "Name of the file to search for"
    default: "*.pdb"
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
  - id: out
    type: stdout
stdout: pdb_list.txt
