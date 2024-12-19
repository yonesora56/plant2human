#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
label: "foldseek easy-search workflow"
doc: |
  foldseek easy-search workflow
  listing files and foldseek easy-search process

requirements:
  - class: WorkReuse
    enableReuse: true

# ----------WORKFLOW INPUTS----------
inputs:
  # listing files
  - id: INPUT_DIRECTORY
    label: "input cif file directory"
    doc: "query protein structure cif file directory"
    type: Directory
    default:
      class: Directory
      location: ../test/oryza_sativa_test/rice_random_gene_mmcif/

  - id: FILE_MATCH_PATTERN
    label: "file match pattern"
    doc: "file match pattern for listing. e.g. *.cif"
    type: string
    default: "*.cif"
  
  - id: FOLDSEEK_INDEX
    label: "foldseek index file"
    doc: "Foldseek index file for searching"
    type: File
    default:
      class: File
      location: ../index/index_swissprot/swissprot
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
    doc: "output file name for foldseek easy-search result (tsv format)"
    type: string
    default: "foldseek_output_swissprot_up_all_evalue01.tsv"

  - id: EVALUE
    label: "e-value"
    doc: "e-value threshold for foldseek easy-search"
    type: double
    default: 0.1

  - id: FORMAT_MODE
    label: "format mode"
    doc: "format mode for foldseek easy-search"
    type: int
    default: 4

  - id: FORMAT_OUTPUT
    label: "format output"
    doc: "format output for foldseek easy-search. separated by comma. e.g. query,target..."
    type: string
    default: "query,target,evalue,prob,gapopen,pident,fident,nident,qstart,qend,qlen,tstart,tend,tlen,alnlen,qcov,tcov,lddt,qtmscore,ttmscore,alntmscore,rmsd,taxid,taxname,taxlineage,qaln,taln,mismatch,lddtfull"

  - id: THREADS
    label: "threads"
    doc: "threads for foldseek easy-search"
    type: int
    default: 16

  - id: SPLIT_MEMORY_LIMIT
    label: "split memory limit"
    doc: "split memory limit for foldseek easy-search"
    type: string
    default: "120G"

  - id: PARAM_INPUT_FORMAT
    label: "input file format"
    doc: "input file format for foldseek easy-search. 0: Auto-detect by extension, 1: PDB, 2: mmCIF, 3: mmJSON, 4: ChemComp, 5: Foldcomp in this workflow default: 2"
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
    doc: "output file for foldseek easy-search result (tsv format)"
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
      files: list_files/files # workflow input
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
