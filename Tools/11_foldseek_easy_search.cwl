#!/usr/bin/env cwl-runner
# Generated from: foldseek easy-search ../Data/rice_up_mmCIFfile/*.cif ../index/index_uniprot/uniprot ../out/foldseek_output_uniprot_up_all_evalue01.tsv ../tmp -e 0.1 --format-mode 4 --format-output query,target,evalue,prob,gapopen,pident,fident,nident,qstart,qend,qlen,tstart,tend,tlen,alnlen,qcov,tcov,lddt,qtmscore,ttmscore,alntmscore,rmsd,taxid,taxname,taxlineage,qaln,taln,mismatch,lddtfull --threads 10 --split-memory-limit 60G
class: CommandLineTool
cwlVersion: v1.2
baseCommand: [foldseek, easy-search]
arguments:
  - $(inputs.mmcif_file)
  - $(inputs.index)
  - $(inputs.output_file_name)
  - $(runtime.tmpdir)
  - -e
  - $(inputs.e_value)
  - --format-mode
  - $(inputs.format_mode)
  - --format-output
  - $(inputs.format_output)
  - --threads
  - $(inputs.threads)
  - --split-memory-limit
  - $(inputs.split_memory_limit)
  - --input-format
  - $(inputs.input_file_format)
  - --taxon-list
  - $(inputs.taxonomy_id_list)
inputs:
  - id: mmcif_file
    type: File[]
  
  - id: index
    type: File
    default:
      class: File
      location: ../index/index_uniprot/uniprot
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
  
  - id: output_file_name
    type: string
    default: "foldseek_output_uniprot_up_all_evalue01.tsv"

  - id: e_value
    type: double
    default: 0.1

  - id: format_mode
    doc: |
      "
      see foldseek easy-search --help
      Output format:
      0: BLAST-TAB
      1: SAM
      2: BLAST-TAB + query/db length
      3: Pretty HTML
      4: BLAST-TAB + column headers
      5: Calpha only PDB super-posed to query
      BLAST-TAB (0) and BLAST-TAB + column headers (4)support custom output formats (--format-output)
      (5) Superposed PDB files (Calpha only) [0]
      "
    type: int
    default: 4

  - id: format_output
    type: string
    default: "query,target,evalue,prob,gapopen,pident,fident,nident,qstart,qend,qlen,tstart,tend,tlen,alnlen,qcov,tcov,lddt,qtmscore,ttmscore,alntmscore,rmsd,taxid,taxname,taxlineage,qaln,taln,mismatch,lddtfull"
  - id: threads
    type: int
    default: 16

  - id: split_memory_limit
    type: string
    default: 120G
  
  - id: input_file_format
    doc: |
      "
      Format of input structures:
      0: Auto-detect by extension
      1: PDB
      2: mmCIF
      3: mmJSON
      4: ChemComp
      5: Foldcomp [0]
      "
    type: int
    default: 2

  - id: taxonomy_id_list
    type: string
    default: "9606,10090,3702,4577,4529"

outputs:
  - id: all
    type: File
    format: edam:format_3475
    outputBinding:
      glob: "*"

# outputs:
#   - id: all
#     type:
#       type: array
#       items:
#         - File
#         - Directory
#     outputBinding:
#       glob: "*"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldseek:9.427df8a--pl5321hb365157_1

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/