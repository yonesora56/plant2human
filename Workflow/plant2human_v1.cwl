#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
label: "plant2human workflow"
doc: |
  plant2human workflow
  listing files: ../Tools/10_listing.cwl
  foldseek easy search: ../Tools/11_foldseek_easy_search.cwl
  extract target species: ../Tools/12_extract_target_species.cwl
  sub-workflow: ./11_retrieve_sequence_wf.cwl
  togoid convert: ../Tools/18_togoid_convert.cwl
  papermill: ../Tools/19_papermill.cwl

requirements:
  - class: WorkReuse
    enableReuse: true
  - class: SubworkflowFeatureRequirement

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

  - id: THREADS
    label: "threads (foldseek easy-search)"
    type: int
    default: 16

  - id: SPLIT_MEMORY_LIMIT
    label: "split memory limit (foldseek easy-search)"
    type: string
    default: "120G"

  # - id: PARAM_INPUT_FORMAT
  #   type: int
  #   default: 2

  - id: TAXONOMY_ID_LIST
    label: "taxonomy id list (foldseek easy-search)"
    doc: "taxonomy id list. separated by comma. Be sure to set “9606”."
    type: string
    default: "9606,10090,3702,4577,4529"
  
  # - id: PARAM_HIT_TAXONOMY_ID
  #   type: int
  #   default: 9606
  
  - id: OUTPUT_FILE_NAME2
    type: string
    default: "foldseek_rice_up_9606.tsv"
  
  - id: WF_COLUMN_NUMBER_QUERY_SPECIES
    label: "column number of query species"
    type: int
    default: 1
  
  - id: OUTPUT_FILE_NAME_QUERY_SPECIES
    type: string
    default: "foldseek_result_query_species.txt"

  - id: WF_COLUMN_NUMBER_HIT_SPECIES
    label: "column number of hit species"
    type: int
    default: 2
  
  - id: OUTPUT_FILE_NAME_HIT_SPECIES
    type: string
    default: "foldseek_result_hit_species.txt"

  # sub-workflow retrieve sequence inputs (makeblastdb)
  - id: SW_INPUT_FASTA_FILE_QUERY_SPECIES
    type: File
    label: "input fasta file (for blastdbcmd)"
    doc: "input fasta file"
    format: edam:format_1332
    default:
      class: File
      format: edam:format_1332
      location: ../Data/Data_uniprot/FASTA_for_index/uniprotkb_rice_all_240820.fasta

  - id: SW_INPUT_FASTA_FILE_HIT_SPECIES
    type: File
    label: "input fasta file (for blastdbcmd)"
    doc: "input fasta file"
    format: edam:format_1332
    default:
      class: File
      format: edam:format_1332
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
    type: string
    default: "uniprot,ensembl_protein,ensembl_transcript,ensembl_gene,hgnc,hgnc_symbol"

  - id: OUTPUT_FILE_NAME3
    label: "output file name (togoid convert)"
    type: string
    default: "foldseek_hit_species_togoid_convert.tsv"

  # papermill process
  - id: OUT_NOTEBOOK_NAME
    label: "output notebook name (papermill)"
    type: string
    default: "plant2human_report.ipynb"

  - id: QUERY_IDMAPPING_TSV
    label: "query idmapping tsv (papermill)"
    type: File
    format: edam:format_3475
    default:
      class: File
      format: edam:format_3475
      location: ../test/workflow_test/rice_up_idmapping.tsv

  - id: QUERY_GENE_LIST_TSV
    label: "query gene list tsv (papermill)"
    type: File
    format: edam:format_3475
    default:
      class: File
      format: edam:format_3475
      location: ../test/workflow_test/HN5_genes_up_rice.tsv

# ----------OUTPUTS----------
outputs:

  - id: tsvfile1
    label: "output file (foldseek easy-search)"
    type: File
    format: edam:format_3475
    outputSource: foldseek_easy_search/all

  - id: tsvfile2
    label: "output file (extract target species)"
    type: File
    format: edam:format_3475
    outputSource: extract_target_species/output_extract_file
  
  - id: idlist1
    label: "output file (extract query species column)"
    type: File
    outputSource: extract_query_species_column/output_file

  - id: idlist2
    label: "output file (extract hit species column)"
    type: File
    format: edam:format_3475
    outputSource: extract_hit_species_column/output_file
  
  # sub-workflow retrieve sequence outputs (makeblastdb)
  - id: index_dir1
    label: "index directory (query species)"
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_index_dir_query_species

  - id: index_files1
    label: "index file (query species)"
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_index_file_query_species

  - id: index_dir2
    label: "index directory (hit species)"
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_index_dir_hit_species

  - id: index_files2
    label: "index file (hit species)"
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_index_file_hit_species

  # sub-workflow retrieve sequence outputs (blastdbcmd)
  - id: blastdbcmd_result1
    label: "blastdbcmd result (query species)"
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_blastdbcmd_result_query_species

  - id: blastdbcmd_result2
    label: "blastdbcmd result (hit species)"
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_blastdbcmd_result_hit_species

  - id: logfile1
    label: "logfile (blastdbcmd query species)"
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_logfile_query_species

  - id: logfile2
    label: "logfile (blastdbcmd hit species)"
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_logfile_hit_species

  # sub-workflow retrieve sequence outputs (seqretsplit)
  - id: dir1
    label: "directory (seqretsplit query species)"
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_dir_query_species

  - id: fasta_files1
    label: "split fasta files (seqretsplit query species)"
    type: File[]
    outputSource: sub_workflow_retrieve_sequence_query_species/output_split_fasta_files_query_species

  - id: dir2
    label: "directory (seqretsplit hit species)"
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_dir_hit_species

  - id: fasta_files2
    label: "split fasta files (seqretsplit hit species)"
    type: File[]
    outputSource: sub_workflow_retrieve_sequence_query_species/output_split_fasta_files_hit_species

  # sub-workflow retrieve sequence outputs (needle)
  - id: dir3
    label: "needle result directory"
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_needle_result_dir

  - id: needle
    label: "needle result file (.needle)"
    type: File[]
    outputSource: sub_workflow_retrieve_sequence_query_species/output_needle_result_file

  # sub-workflow retrieve sequence outputs (water)
  - id: dir4
    label: "water result directory"
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_water_result_dir

  - id: water
    label: "water result file (.water)"
    type: File[]
    outputSource: sub_workflow_retrieve_sequence_query_species/output_water_result_file

  - id: tsvfile3
    label: "output file (togoid convert)"
    type: File
    format: edam:format_3475
    outputSource: togoid_convert/output_file

  - id: report_notebook
    label: "output notebook (papermill)"
    type: File
    outputSource: papermill/report_notebook


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
      threads: THREADS
      split_memory_limit: SPLIT_MEMORY_LIMIT
      taxonomy_id_list: TAXONOMY_ID_LIST
    out:
      - all

  extract_target_species:
    run: ../Tools/12_extract_target_species.cwl
    in:
      input_file: foldseek_easy_search/all # workflow output
      output_file_name: OUTPUT_FILE_NAME2
    out:
      - output_extract_file
  
  extract_query_species_column:
    run: ../Tools/13_extract_id.cwl
    in:
      tsvfile: extract_target_species/output_extract_file # workflow output
      column_number: WF_COLUMN_NUMBER_QUERY_SPECIES
      output_file_name: OUTPUT_FILE_NAME_QUERY_SPECIES
    out:
      - output_file

  extract_hit_species_column:
    run: ../Tools/13_extract_id.cwl
    in:
      tsvfile: extract_target_species/output_extract_file # workflow output
      column_number: WF_COLUMN_NUMBER_HIT_SPECIES
      output_file_name: OUTPUT_FILE_NAME_HIT_SPECIES
    out: 
      - output_file

  sub_workflow_retrieve_sequence_query_species:
    run: ./11_retrieve_sequence_wf.cwl
    doc: |
      "
      ../Tools/14_makeblastdb.cwl
      ../Tools/15_blastdbcmd.cwl
      ../Tools/16_seqretsplit.cwl
      ../Tools/17_needle.cwl
      ../Tools/18_water.cwl
      "
    in:
      PARAM_INPUT_FASTA_FILE_QUERY_SPECIES: SW_INPUT_FASTA_FILE_QUERY_SPECIES
      PARAM_INPUT_FASTA_FILE_HIT_SPECIES: SW_INPUT_FASTA_FILE_HIT_SPECIES
      PARAM_ENTRY_BATCH_QUERY_SPECIES: extract_query_species_column/output_file # workflow output
      PARAM_ENTRY_BATCH_HIT_SPECIES: extract_hit_species_column/output_file # workflow output
      PARAM_FOLDSEEK_EXTRACT_TSV: extract_target_species/output_extract_file # workflow output
      PARAM_ALIGNMENT_QUERY_COL_NUM: WF_COLUMN_NUMBER_QUERY_SPECIES
      PARAM_ALIGNMENT_TARGET_COL_NUM: WF_COLUMN_NUMBER_HIT_SPECIES
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
    run: ../Tools/18_togoid_convert.cwl
    in:
      id_convert_file: extract_hit_species_column/output_file # workflow output
      route_dataset: ROUTE_DATASET
      output_file_name: OUTPUT_FILE_NAME3
    out:
      - output_file

  papermill:
    run: ../Tools/19_papermill.cwl
    in:
      report_notebook_name: OUT_NOTEBOOK_NAME
      foldseek_result_tsv: extract_target_species/output_extract_file # workflow output
      query_uniprot_idmapping_tsv: QUERY_IDMAPPING_TSV
      water_result_dir: sub_workflow_retrieve_sequence_query_species/output_water_result_dir
      needle_result_dir: sub_workflow_retrieve_sequence_query_species/output_needle_result_dir
      query_gene_list_tsv: QUERY_GENE_LIST_TSV
      togoid_convert_tsv: togoid_convert/output_file
    out:
      - report_notebook

# metadata
s:dateCreated: "2024-11-08"
s:license: https://spdx.org/licenses/MIT

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/
