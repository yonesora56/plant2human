#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool
label: "Listing files"
doc: "List files in a directory for foldseek easy-search process. e.g. ../Data/rice_up_mmCIFfile/*.cif"

# Reference: https://qiita.com/kyusque/items/a291fd251a10f783390e#3-glob%E7%94%A8%E3%81%AEclt%E3%82%92%E4%BD%BF%E3%81%86
baseCommand: [ls]
inputs:
  - id: glob_root
    label: "Root directory"
    type: Directory
    default:
      class: Directory
      location: ../test/oryza_sativa_test_202509/rice_random_gene_mmcif/
  - id: glob_pattern
    label: "File pattern"
    type: string
    default: "*.cif"

outputs:
  - id: files
    type: File[]
    outputBinding:
      # glob: $(inputs.glob_root.path)/$(inputs.glob_pattern)
      glob: $(inputs.glob_root.basename)/$(inputs.glob_pattern)
# stdout: listing.txt

# Reference: https://zenn.dev/tom_tan/articles/568852ad644a02
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.glob_root)