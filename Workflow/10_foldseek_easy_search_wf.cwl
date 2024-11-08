#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
label: "foldseek easy-search workflow"
doc: |
  foldseek easy-search workflow

requirements:
  - class: WorkReuse
    enableReuse: true

# ----------WORKFLOW INPUTS----------
inputs:
  # listing files
  - id: INPUT_DIRECTORY
    doc: "query protein structure cif file directory"
    type: Directory
    default:
      class: Directory
      location: ../out/rice_up/rice_up_mmcif/

  - id: FILE_MATCH_PATTERN
    doc: "file match pattern for listing"
    type: string
    default: "*.cif"
  
  - id: FOLDSEEK_INDEX
    label: "foldseek index file"
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

  - id: OUTPUT_FILE_NAME1
    label: "output file name (foldseek easy-search)"
    type: string
    default: "foldseek_output_uniprot_up_all_evalue01.tsv"

  - id: EVALUE
    label: "e-value (foldseek easy-search)"
    type: double
    default: 0.1

  - id: FORMAT_MODE
    label: "format mode (foldseek easy-search)"
    type: int
    default: 4

  - id: FORMAT_OUTPUT
    label: "format output (foldseek easy-search)"
    type: string
    default: "query,target,evalue,prob,gapopen,pident,fident,nident,qstart,qend,qlen,tstart,tend,tlen,alnlen,qcov,tcov,lddt,qtmscore,ttmscore,alntmscore,rmsd,taxid,taxname,taxlineage,qaln,taln,mismatch,lddtfull"

  - id: THREADS
    label: "threads (foldseek easy-search)"
    type: int
    default: 16

  - id: SPLIT_MEMORY_LIMIT
    label: "split memory limit (foldseek easy-search)"
    type: string
    default: "120G"

  - id: PARAM_INPUT_FORMAT
    type: int
    default: 2

  - id: TAXONOMY_ID_LIST
    label: "taxonomy id list (foldseek easy-search)"
    doc: "taxonomy id list. separated by comma. Be sure to set “9606”."
    type: string
    default: "9606,10090,3702,4577,4529"


# ----------OUTPUTS----------
outputs:

  - id: tsvfile
    label: "output file (foldseek easy-search)"
    type: File
    format: edam:format_3475
    outputSource: foldseek_easy_search/all


# ----------STEPS----------
steps:
  list_files:
    run: ../Tools/10_listing.cwl
    in:
      glob_root: INPUT_DIRECTORY
      glob_pattern: FILE_MATCH_PATTERN
    out:
      - files

  foldseek_easy_search:
    run: ../Tools/11_foldseek_easy_search.cwl
    in:
      mmcif_files: list_files/files # workflow input
      index: FOLDSEEK_INDEX
      output_file_name: OUTPUT_FILE_NAME1
      e_value: EVALUE
      format_mode: FORMAT_MODE
      format_output: FORMAT_OUTPUT
      threads: THREADS
      split_memory_limit: SPLIT_MEMORY_LIMIT
      input_file_format: PARAM_INPUT_FORMAT
      taxonomy_id_list: TAXONOMY_ID_LIST
    out:
      - all

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/
