#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
label: "foldseek easy-search workflow (Stringent Mode)"
doc: |
  "foldseek easy-search sub-workflow for plant2human workflow (Stringent Mode)
  Uses self-built Foldseek index (e.g., Human Proteome v6) without taxonomy filtering.
  Step 1: listing files
  Step 2: foldseek easy-search process"

requirements:
  - class: WorkReuse
    enableReuse: true

# ----------WORKFLOW INPUTS----------
inputs:
  # listing files
  - id: INPUT_DIRECTORY
    label: "input protein structure files directory"
    doc: "input protein structure files directory (default: ../test/oryza_sativa_test/rice_random_gene_mmcif/)"
    type: Directory
    default:
      class: Directory
      location: ../test/oryza_sativa_test_100genes_202512/os_100_genes_mmcif/

  - id: FILE_MATCH_PATTERN
    label: "file match pattern"
    doc: "file match pattern for listing. in this workflow, default is *.cif"
    type: string
    default: "*.cif"
  
  - id: FOLDSEEK_INDEX
    label: "foldseek index file (Stringent Mode)"
    doc: "Foldseek index file for searching. This index should be created using `foldseek createdb` from downloaded proteome files (e.g., Human Proteome v6)."
    type: File
    default:
      class: File
      location: ../index/index_human_proteome_v6/human_proteome_v6
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
      # No _taxonomy for self-built index
      - .dbtype
      - .index
      - .lookup
      - .source
      # No .version for self-built index

  - id: OUTPUT_FILE_NAME1
    label: "output file name (foldseek easy-search)"
    doc: "output file name for foldseek easy-search result (tsv format). default: foldseek_output_human_proteome_v6_up_all_evalue01.tsv"
    type: string
    default: "foldseek_output_human_proteome_v6_up_all_evalue01.tsv"

  - id: EVALUE
    label: "e-value (foldseek easy-search)"
    doc: "e-value threshold for foldseek easy-search. default: 0.1"
    type: double
    default: 0.1

  - id: ALIGNMENT_TYPE
    label: "alignment type (foldseek easy-search)"
    doc: "alignment type for foldseek easy-search. for more details, see `foldseek easy-search --help`
      How to compute the alignment:
      0: 3di alignment
      1: TM alignment
      2: 3Di+AA default: 2"
    type: int
    default: 2

  - id: FORMAT_MODE
    label: "format mode (foldseek easy-search)"
    doc: "format mode for foldseek easy-search. for more details, see `foldseek easy-search --help`
      Output format list:
      0: BLAST-TAB
      1: SAM
      2: BLAST-TAB + query/db length
      3: Pretty HTML
      4: BLAST-TAB + column headers
      5: Calpha only PDB super-posed to query
      BLAST-TAB (0) and BLAST-TAB + column headers (4)support custom output formats (--format-output)
      (5) Superposed PDB files (Calpha only) [0]
      default: 4"
    type: int
    default: 4

  - id: FORMAT_OUTPUT
    label: "format output (foldseek easy-search)"
    doc: "format output for foldseek easy-search. Stringent mode: taxid, taxname, taxlineage are removed."
    type: string
    default: "query,target,evalue,prob,gapopen,pident,fident,nident,qstart,qend,qlen,tstart,tend,tlen,alnlen,qcov,tcov,lddt,qtmscore,ttmscore,alntmscore,rmsd,qaln,taln,mismatch,lddtfull"

  - id: THREADS
    label: "threads (foldseek easy-search)"
    doc: "threads for foldseek easy-search. default: 16"
    type: int
    default: 16

  - id: SPLIT_MEMORY_LIMIT
    label: "split memory limit (foldseek easy-search)"
    doc: "split memory limit for foldseek easy-search. default: 120G"
    type: string
    default: "120G"

  - id: PARAM_INPUT_FORMAT
    label: "input file format (foldseek easy-search)"
    doc: "input file format for foldseek easy-search. 0: Auto-detect by extension, 1: PDB, 2: mmCIF, 3: mmJSON, 4: ChemComp, 5: Foldcomp in this workflow default: 2"
    type: int
    default: 2

  # No TAXONOMY_ID_LIST for Stringent Mode


# ----------OUTPUTS----------
outputs:

  - id: tsvfile
    label: "output file (foldseek easy-search)"
    doc: "output file for foldseek easy-search result (tsv format)."
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
    run: ../Tools/11_foldseek_easy_search_stringent.cwl
    in:
      files: list_files/files
      index: FOLDSEEK_INDEX
      output_file_name: OUTPUT_FILE_NAME1
      e_value: EVALUE
      alignment_type: ALIGNMENT_TYPE
      format_mode: FORMAT_MODE
      format_output: FORMAT_OUTPUT
      threads: THREADS
      split_memory_limit: SPLIT_MEMORY_LIMIT
      input_file_format: PARAM_INPUT_FORMAT
      # No taxonomy_id_list for Stringent Mode
    out:
      - all

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/
