#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
label: "plant2human workflow"
doc: |
  "Novel gene discovery workflow by comparing plant species and human based on structural similarity search."

requirements:
  - class: WorkReuse
    enableReuse: true
  - class: SubworkflowFeatureRequirement

# ----------WORKFLOW INPUTS----------
inputs:
  # foldseek easy-search sub-workflow inputs
  - id: INPUT_DIRECTORY
    label: "input structure file directory"
    doc: "query protein structure file (default: mmCIF) directory for foldseek easy-search input."
    type: Directory
    default:
      class: Directory
      location: ../test/oryza_sativa_test/rice_random_gene_mmcif/

  - id: FILE_MATCH_PATTERN
    label: "file match pattern"
    doc: "file match pattern for listing input files. default: *.cif"
    type: string
    default: "*.cif"
  
  - id: FOLDSEEK_INDEX
    label: "foldseek index file"
    doc: |
      foldseek index file for foldseek easy-search input.
      This index file can be retrieved by executing the `foldseek databases` command.
      example: `foldseek databases Alphafold/Swiss-Prot index_swissprot/swissprot tmp --threads 8`
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
    doc: "output file name for foldseek easy-search result. Currently, this workflow only supports TSV file output."
    format: edam:data_1050
    type: string
    default: "foldseek_output_swissprot_up_all_evalue01.tsv"

  - id: EVALUE
    label: "e-value (foldseek easy-search)"
    doc: "e-value threshold for foldseek easy-search. workflowdefault: 0.1"
    type: double
    default: 0.1

  - id: THREADS
    label: "threads (foldseek easy-search)"
    doc: "threads for foldseek easy-search. default: 16"
    type: int
    default: 16

  - id: SPLIT_MEMORY_LIMIT
    label: "split memory limit (foldseek easy-search)"
    doc: "split memory limit for foldseek easy-search. default: 120G"
    type: string
    default: "60G"

  # - id: PARAM_INPUT_FORMAT
  #   type: int
  #   default: 2

  - id: TAXONOMY_ID_LIST
    label: "taxonomy id list (foldseek easy-search)"
    doc: "taxonomy id list. separated by comma. Be sure to set “9606”. default: 9606 (human), 10090 (mouse), 3702 (Arabidopsis), 4577 (Zea mays), 4529 (Oryza rufipogon)"
    type: string
    default: "9606,10090,3702,4577,4529"
  
  # - id: PARAM_HIT_TAXONOMY_ID
  #   type: int
  #   default: 9606
  
  - id: OUTPUT_FILE_NAME2
    label: "output file name (extract target species)"
    doc: "output file name for extract target species (default: human) python script."
    format: edam:data_1050
    type: string
    default: "foldseek_os_random_9606.tsv"
  
  - id: WF_COLUMN_NUMBER_QUERY_SPECIES
    label: "column number of query species"
    doc: "column number of query species. default: 1 (UniProt ID list)"
    type: int
    default: 1
  
  - id: OUTPUT_FILE_NAME_QUERY_SPECIES
    label: "output file name (extract query species column)"
    doc: "output file name for extract query species column python script. default: foldseek_result_query_species.txt"
    format: edam:data_1050
    type: string
    default: "foldseek_result_query_species.txt"

  - id: WF_COLUMN_NUMBER_HIT_SPECIES
    label: "column number of hit species"
    doc: "column number of hit species. default: 2 (UniProt ID list)"
    type: int
    default: 2
  
  - id: OUTPUT_FILE_NAME_HIT_SPECIES
    label: "output file name (extract hit species column)"
    doc: "output file name for extract hit species column python script. default: foldseek_result_hit_species.txt"
    format: edam:data_1050
    type: string
    default: "foldseek_result_hit_species.txt"

  # sub-workflow retrieve sequence inputs
  - id: SW_INPUT_FASTA_FILE_QUERY_SPECIES
    type: File
    label: "input fasta file (for blastdbcmd)"
    doc: "input fasta file for blastdbcmd. Retrieve files in advance. default: rice UniProt FASTA file"
    format: edam:format_1929
    default:
      class: File
      format: edam:format_1929
      location: ../Data/Data_uniprot/FASTA_for_index/uniprotkb_rice_all_240820.fasta

  - id: SW_INPUT_FASTA_FILE_HIT_SPECIES
    type: File
    label: "input fasta file (for blastdbcmd)"
    doc: "input fasta file for blastdbcmd. Retrieve files in advance. default: human UniProt FASTA file"
    format: edam:format_1929
    default:
      class: File
      format: edam:format_1929
      location: ../Data/Data_uniprot/FASTA_for_index/uniprotkb_human_all_241107.fasta

  # - id: SW_ALIGNMENT_QUERY_COL_NUM
  #   type: int
  #   default: 1

  # - id: SW_PARAM_ALIGNMENT_TARGET_COL_NUM
  #   type: int
  #   default: 2
  
  # togoid convert process
  - id: ROUTE_DATASET
    label: "route dataset (togoid convert)"
    doc: "route dataset for togoid convert. This operation selects the UniProt ID of the target species (human) for which cross-references exist (final destination is HGNC gene symbol). default: uniprot,ensembl_protein,ensembl_transcript,ensembl_gene,hgnc,hgnc_symbol"
    type: string
    default: "uniprot,ensembl_protein,ensembl_transcript,ensembl_gene,hgnc,hgnc_symbol"

  - id: OUTPUT_FILE_NAME3
    label: "output file name (togoid convert)"
    doc: "output file name for togoid convert python script. default: foldseek_hit_species_togoid_convert.tsv"
    format: edam:data_1050
    type: string
    default: "foldseek_hit_species_togoid_convert.tsv"

  # papermill process
  - id: OUT_NOTEBOOK_NAME
    label: "output notebook name (papermill)"
    doc: "output notebook name for papermill.  After the analysis workflow is output, it can be freely customized such as changing the parameter values. default: plant2human_report.ipynb"
    format: edam:data_1050
    type: string
    default: "plant2human_report.ipynb"

  - id: QUERY_IDMAPPING_TSV
    label: "query idmapping tsv (papermill)"
    doc: "query idmapping tsv file. Retrieve files in advance. default: rice UniProt ID mapping file"
    type: File
    format: edam:format_3475
    default:
      class: File
      format: edam:format_3475
      location: ../test/oryza_sativa_test/rice_random_gene_idmapping_all.tsv

  - id: QUERY_GENE_LIST_TSV
    label: "query gene list tsv (papermill)"
    doc: "query gene list tsv file. Retrieve files in advance. default: rice random gene list"
    type: File
    format: edam:format_3475
    default:
      class: File
      format: edam:format_3475
      location: ../test/oryza_sativa_test/oryza_sativa_random_gene_list.tsv

# ----------OUTPUTS----------
outputs:

  - id: TSVFILE1
    label: "output file (foldseek easy-search)"
    doc: "output file for foldseek easy-search all hit result."
    type: File
    format: edam:format_3475
    outputSource: sub_workflow_foldseek_easy_search/tsvfile

  - id: TSVFILE2
    label: "output file (extract target species)"
    doc: "extract target species foldseek result file. (in this workflow, human result only)"
    type: File
    format: edam:format_3475
    outputSource: extract_target_species/output_extract_file
  
  - id: IDLIST1
    label: "output file (extract query species column)"
    doc: "extract query species column UniProt ID list file."
    type: File
    outputSource: extract_query_species_column/output_file

  - id: IDLIST2
    label: "output file (extract hit species column)"
    doc: "extract hit species column UniProt ID list file."
    type: File
    outputSource: extract_hit_species_column/output_file
  
  # sub-workflow retrieve sequence outputs (makeblastdb)
  - id: INDEX_DIR1
    label: "index directory (query species)"
    doc: "index directory for query species."
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_index_dir_query_species

  - id: INDEX_FILES1
    label: "index files (query species)"
    doc: "index files for query species."
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_index_file_query_species

  - id: INDEX_DIR2
    label: "index directory (hit species)"
    doc: "index directory for hit species."
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_index_dir_hit_species

  - id: INDEX_FILES2
    label: "index files (hit species)"
    doc: "index files for hit species."
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_index_file_hit_species

  # sub-workflow retrieve sequence outputs (blastdbcmd)
  - id: BLASTDBCMD_RESULT1
    label: "blastdbcmd result (query species)"
    doc: "blastdbcmd result file for query species."
    type: File
    format: edam:format_1929
    outputSource: sub_workflow_retrieve_sequence_query_species/output_blastdbcmd_result_query_species

  - id: BLASTDBCMD_RESULT2
    label: "blastdbcmd result (hit species)"
    doc: "blastdbcmd result file for hit species."
    type: File
    format: edam:format_1929
    outputSource: sub_workflow_retrieve_sequence_query_species/output_blastdbcmd_result_hit_species

  - id: LOGFILE1
    label: "logfile (blastdbcmd query species)"
    doc: "logfile for blastdbcmd query species."
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_logfile_query_species

  - id: LOGFILE2
    label: "logfile (blastdbcmd hit species)"
    doc: "logfile for blastdbcmd hit species."
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_logfile_hit_species

  # sub-workflow retrieve sequence outputs (seqretsplit)
  - id: DIR1
    label: "directory (seqretsplit query species)"
    doc: "directory for seqretsplit query species."
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_dir_query_species

  - id: FASTA_FILES1
    label: "split fasta files (seqretsplit query species)"
    doc: "split fasta files using seqretsplit for pairwise sequence alignment."
    type: File[]
    format: edam:format_1929
    outputSource: sub_workflow_retrieve_sequence_query_species/output_split_fasta_files_query_species

  - id: DIR2
    label: "directory (seqretsplit hit species)"
    doc: "directory for seqretsplit hit species."
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_dir_hit_species

  - id: FASTA_FILES2
    label: "split fasta files (seqretsplit hit species)"
    doc: "split fasta files using seqretsplit for pairwise sequence alignment."
    type: File[]
    format: edam:format_1929
    outputSource: sub_workflow_retrieve_sequence_query_species/output_split_fasta_files_hit_species

  # sub-workflow retrieve sequence outputs (needle)
  - id: DIR3
    label: "needle result directory"
    doc: "needle (global alignment) result directory."
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_needle_result_dir

  - id: NEEDLE_RESULT_FILE
    label: "needle result file (.needle)"
    doc: "needle (global alignment) result files. suffix is .needle."
    type: File[]
    outputSource: sub_workflow_retrieve_sequence_query_species/output_needle_result_file

  # sub-workflow retrieve sequence outputs (water)
  - id: DIR4
    label: "water result directory"
    doc: "water (local alignment) result directory."
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_water_result_dir

  - id: WATER_RESULT_FILE
    label: "water result file (.water)"
    doc: "water (local alignment) result files. suffix is .water."
    type: File[]
    outputSource: sub_workflow_retrieve_sequence_query_species/output_water_result_file

  - id: TSVFILE3
    label: "output file (togoid convert)"
    doc: "output file for togoid convert."
    type: File
    format: edam:format_3475
    outputSource: togoid_convert/output_file

  - id: REPORT_NOTEBOOK
    label: "output notebook (papermill)"
    doc: "output notebook using papermill. notebook name is `plant2human_report.ipynb`."
    type: File
    outputSource: papermill/report_notebook


# ----------STEPS----------
steps:
  sub_workflow_foldseek_easy_search:
    label: "foldseek easy-search sub-workflow process"
    doc: "Execute foldseek easy-search using foldseek using BioContainers docker image. This workflow supports only TSV file output. execute: ./10_foldseek_easy_search_wf.cwl"
    run: ./10_foldseek_easy_search_wf.cwl
    in:
      INPUT_DIRECTORY: INPUT_DIRECTORY
      FILE_MATCH_PATTERN: FILE_MATCH_PATTERN
      FOLDSEEK_INDEX: FOLDSEEK_INDEX
      OUTPUT_FILE_NAME1: OUTPUT_FILE_NAME1
      EVALUE: EVALUE
      THREADS: THREADS
      SPLIT_MEMORY_LIMIT: SPLIT_MEMORY_LIMIT
      TAXONOMY_ID_LIST: TAXONOMY_ID_LIST
    out:
      - tsvfile

  extract_target_species:
    label: "extract target species (human) process"
    doc: "Extract target species (human) from foldseek easy-search result. execute: ../Tools/12_extract_target_species.cwl"
    run: ../Tools/12_extract_target_species.cwl
    in:
      input_file: sub_workflow_foldseek_easy_search/tsvfile # workflow input
      output_file_name: OUTPUT_FILE_NAME2
    out:
      - output_extract_file
  
  extract_query_species_column:
    label: "extract query species column process"
    doc: "Extract query species column (UniProt ID list) from foldseek easy-search result. execute: ../Tools/13_extract_id.cwl"
    run: ../Tools/13_extract_id.cwl
    in:
      tsvfile: extract_target_species/output_extract_file # workflow input
      column_number: WF_COLUMN_NUMBER_QUERY_SPECIES
      output_file_name: OUTPUT_FILE_NAME_QUERY_SPECIES
    out:
      - output_file

  extract_hit_species_column:
    label: "extract hit species column process"
    doc: "Extract hit species column (UniProt ID list) from foldseek easy-search result. execute: ../Tools/13_extract_id.cwl"
    run: ../Tools/13_extract_id.cwl
    in:
      tsvfile: extract_target_species/output_extract_file # workflow input
      column_number: WF_COLUMN_NUMBER_HIT_SPECIES
      output_file_name: OUTPUT_FILE_NAME_HIT_SPECIES
    out: 
      - output_file

  sub_workflow_retrieve_sequence_query_species:
    label: "retrieve sequence sub-workflow process using EMBOSS package"
    doc: |
      "
      In this process, pairwise alignment (needle and water) is performed on the pairs that were found in the structural similarity search to obtain information on sequence similarity (identity and similarity).
      execute: ./11_retrieve_sequence_wf.cwl 
      retrieve sequence from blastdbcmd result: makeblastdb: ../Tools/14_makeblastdb.cwl
      blastdbcmd: ../Tools/15_blastdbcmd.cwl
      split fasta files for seqretsplit: ../Tools/16_seqretsplit.cwl
      needle (Global alignment): ../Tools/17_needle.cwl
      water (Local alignment): ../Tools/17_water.cwl
      "
    run: ./11_retrieve_sequence_wf.cwl
    in:
      INPUT_FASTA_FILE_QUERY_SPECIES: SW_INPUT_FASTA_FILE_QUERY_SPECIES
      INPUT_FASTA_FILE_HIT_SPECIES: SW_INPUT_FASTA_FILE_HIT_SPECIES
      ENTRY_BATCH_QUERY_SPECIES: extract_query_species_column/output_file # workflow input
      ENTRY_BATCH_HIT_SPECIES: extract_hit_species_column/output_file # workflow input
      FOLDSEEK_EXTRACT_TSV: extract_target_species/output_extract_file # workflow input
      ALIGNMENT_QUERY_COLUMN_NUMBER: WF_COLUMN_NUMBER_QUERY_SPECIES
      ALIGNMENT_TARGET_COLUMN_NUMBER: WF_COLUMN_NUMBER_HIT_SPECIES
    out:
      - output_index_dir_query_species
      - output_index_file_query_species
      - output_index_dir_hit_species
      - output_index_file_hit_species
      - output_blastdbcmd_result_query_species
      - output_logfile_query_species
      - output_blastdbcmd_result_hit_species
      - output_logfile_hit_species
      - output_dir_query_species
      - output_split_fasta_files_query_species
      - output_dir_hit_species
      - output_split_fasta_files_hit_species
      - output_needle_result_dir
      - output_needle_result_file
      - output_water_result_dir
      - output_water_result_file
  
  togoid_convert:
    label: "togoid convert process"
    doc: "retrieve UniProt ID to HGNC gene symbol. execute: ../Tools/18_togoid_convert.cwl"
    run: ../Tools/18_togoid_convert.cwl
    in:
      id_convert_file: extract_hit_species_column/output_file # workflow input
      route_dataset: ROUTE_DATASET
      output_file_name: OUTPUT_FILE_NAME3
    out:
      - output_file

  papermill:
    label: "papermill process"
    doc: "output notebook using papermill. This process allows you to create a scatter plot of structural similarity vs. sequence similarity. execute: ../Tools/19_papermill.cwl"
    run: ../Tools/19_papermill.cwl
    in:
      report_notebook_name: OUT_NOTEBOOK_NAME
      foldseek_result_tsv: extract_target_species/output_extract_file # workflow input
      query_uniprot_idmapping_tsv: QUERY_IDMAPPING_TSV
      water_result_dir: sub_workflow_retrieve_sequence_query_species/output_water_result_dir # workflow input
      needle_result_dir: sub_workflow_retrieve_sequence_query_species/output_needle_result_dir # workflow input
      query_gene_list_tsv: QUERY_GENE_LIST_TSV 
      togoid_convert_tsv: togoid_convert/output_file # workflow input
    out:
      - report_notebook

# metadata
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0004-1874-3117
    s:email: d246887@hiroshima-u.ac.jp
    s:name: Sora Yonezawa


s:codeRepository: https://github.com/yonesora56/plant2human
s:dateCreated: "2024-11-13"
s:license: https://spdx.org/licenses/MIT

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/