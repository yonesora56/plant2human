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
    label: "input protein structure files directory"
    doc: "input protein structure files directory (default: ../test/oryza_sativa_test/rice_random_gene_mmcif/)"
    type: Directory
    default:
      class: Directory
      location: ../test/oryza_sativa_test/rice_random_gene_mmcif/

  - id: FILE_MATCH_PATTERN
    label: "file match pattern"
    doc: "file match pattern for listing. in this workflow, default is *.cif"
    type: string
    default: "*.cif"
  
  - id: FOLDSEEK_INDEX
    label: "foldseek index file"
    doc: "Foldseek index file for searching. This index file can be retrieved by executing the `foldseek databases` command. example: `foldseek databases Alphafold/Swiss-Prot index_swissprot/swissprot tmp --threads 8`"
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
    doc: "output file name for foldseek easy-search result (tsv format). default: foldseek_output_swissprot_up_all_evalue01.tsv"
    type: string
    default: "foldseek_output_swissprot_up_all_evalue01.tsv"

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
      2: 3Di+AAdefault: 2"
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
    doc: "format output for foldseek easy-search. separated by comma. e.g. query,target..."
    type: string
    default: "query,target,evalue,prob,gapopen,pident,fident,nident,qstart,qend,qlen,tstart,tend,tlen,alnlen,qcov,tcov,lddt,qtmscore,ttmscore,alntmscore,rmsd,taxid,taxname,taxlineage,qaln,taln,mismatch,lddtfull"

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

  - id: TAXONOMY_ID_LIST
    label: "taxonomy id list (foldseek easy-search)"
    doc: "taxonomy id list. separated by comma. Be sure to set “9606”. 
    This workflow does not consider results for non-human species, but foldseek's output results include other species and can be customized by the user.
    default: 9606,10090,3702,4577,4529"
    type: string
    default: "9606,10090,3702,4577,4529"


# ----------OUTPUTS----------
outputs:

  - id: tsvfile
    label: "output file (foldseek easy-search)"
    doc: "output file for foldseek easy-search result (tsv format). default: foldseek_output_swissprot_up_all_evalue01.tsv"
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
      alignment_type: ALIGNMENT_TYPE
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
