#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
label: "foldseek easy-search sub-workflow"
doc: |
  Three steps to retrieve sequence from blastdbcmd result
  makeblastdb: ../Tools/14_makeblastdb.cwl
  blastdbcmd: ../Tools/15_blastdbcmd.cwl
  seqretsplit: ../Tools/16_seqretsplit.cwl
  needle (Global alignment): ../Tools/17_needle.cwl
  water (Local alignment): ../Tools/17_water.cwl

requirements:
  WorkReuse:
    enableReuse: true

# ----------WORKFLOW INPUTS----------
inputs:
  # makeblastdb inputs
  - id: PARAM_INDEX_DIR_NAME_QUERY_SPECIES
    type: string
    doc: "index directory name"
    default: index_uniprot_rice

  - id: PARAM_INDEX_DIR_NAME_HIT_SPECIES
    type: string
    doc: "index directory name"
    default: index_uniprot_human
  
  - id: PARAM_INPUT_FASTA_FILE_QUERY_SPECIES
    type: File
    doc: "input fasta file"
    format: edam:format_1332
    default:
      class: File
      format: edam:format_1332
      location: file:///workspaces/004_foldseek/Data/Data_uniprot/FASTA_for_index/uniprotkb_rice_all_240820.fasta

  - id: PARAM_INPUT_FASTA_FILE_HIT_SPECIES
    type: File
    doc: "input fasta file"
    format: edam:format_1332
    default:
      class: File
      format: edam:format_1332
      location: file:///workspaces/004_foldseek/Data/Data_uniprot/FASTA_for_index/uniprotkb_human_all_241107.fasta
    
  - id: PARAM_OUTPUT_INDEX_NAME_QUERY_SPECIES
    type: string
    doc: "output index name"
    default: uniprotkb_rice_all_240820

  - id: PARAM_OUTPUT_INDEX_NAME_HIT_SPECIES
    type: string
    doc: "output index name"
    default: uniprotkb_human_all_241107

  - id: PARAM_DBTYPE
    type: string
    doc: "database type"
    default: "prot"

  # blastdbcmd inputs
  - id: PARAM_ENTRY_BATCH_QUERY_SPECIES
    type: File
    doc: "entry batch file"
    default:
      class: File
      location: file:///workspaces/004_foldseek/test/workflow_test/foldseek_result_query_species.txt

  - id: PARAM_ENTRY_BATCH_HIT_SPECIES
    type: File
    doc: "entry batch file"
    default:
      class: File
      location: file:///workspaces/004_foldseek/test/workflow_test/foldseek_result_hit_species.txt

  - id: PARAM_RETRIEVE_RESULT_FILE_NAME_QUERY_SPECIES
    type: string
    doc: "retrieve result file name"
    default: "blastdbcmd_result_query_species.fasta"

  - id: PARAM_LOGFILE_NAME_QUERY_SPECIES
    type: string
    doc: "logfile name"
    default: "blastdbcmd_result_query_species.log"

  - id: PARAM_RETRIEVE_RESULT_FILE_NAME_HIT_SPECIES
    type: string
    doc: "retrieve result file name"
    default: "blastdbcmd_result_hit_species.fasta"

  - id: PARAM_LOGFILE_NAME_HIT_SPECIES
    type: string
    doc: "logfile name"
    default: "blastdbcmd_result_hit_species.log"

  # seqretsplit inputs
  - id: PARAM_SEQUENCE_FORMAT
    type: string
    doc: "sequence format"
    default: "fasta"

  - id: PARAM_OUTPUT_SEQRETSPLIT_DIR_NAME_QUERY_SPECIES
    type: string
    doc: "output directory name"
    default: "split_fasta_query_species"

  - id: PARAM_OUTPUT_SEQRETSPLIT_DIR_NAME_HIT_SPECIES
    type: string
    doc: "output directory name"
    default: "split_fasta_hit_species"

  # needle and water inputs
  - id: NEEDLE_SCRIPT
    type: File
    doc: "needle script"
    default:
      class: File
      location: file:///workspaces/004_foldseek/scripts/run_needle.sh

  - id: WATER_SCRIPT
    type: File
    doc: "water script"
    default:
      class: File
      location: file:///workspaces/004_foldseek/scripts/run_water.sh

  - id: PARAM_FOLDSEEK_EXTRACT_TSV
    type: File
    doc: "foldseek extract tsv"
    format: edam:format_3475
    default:
      class: File
      format: edam:format_3475
      location: file:///workspaces/004_foldseek/test/workflow_test/foldseek_rice_up_9606.tsv
  
  - id: PARAM_NEEDLE_RESULT_DIR_NAME
    type: string
    doc: "needle result directory name"
    default: "result_needle"

  - id: PARAM_WATER_RESULT_DIR_NAME
    type: string
    doc: "water result directory name"
    default: "result_water"

  - id: PARAM_ALIGNMENT_QUERY_COL_NUM
    type: int
    doc: "alignment query column number"
    default: 1

  - id: PARAM_ALIGNMENT_TARGET_COL_NUM
    type: int
    doc: "alignment target column number"
    default: 2



# ----------OUTPUTS----------
outputs:
  # makeblastdb outputs
  - id: output_index_dir_query_species
    type: Directory
    outputSource: makeblastdb_query_species/index_dir

  - id: output_index_file_query_species
    type: File
    outputSource: makeblastdb_query_species/index_file

  - id: output_index_dir_hit_species
    type: Directory
    outputSource: makeblastdb_hit_species/index_dir

  - id: output_index_file_hit_species
    type: File
    outputSource: makeblastdb_hit_species/index_file

  # blastdbcmd outputs
  - id: output_blastdbcmd_result_query_species
    type: File
    outputSource: blastdbcmd_query_species/blastdbcmd_result

  - id: output_logfile_query_species
    type: File
    outputSource: blastdbcmd_query_species/logfile

  - id: output_blastdbcmd_result_hit_species
    type: File
    outputSource: blastdbcmd_hit_species/blastdbcmd_result

  - id: output_logfile_hit_species
    type: File
    outputSource: blastdbcmd_hit_species/logfile

  # seqretsplit outputs
  - id: output_dir_query_species
    type: Directory
    outputSource: seqretsplit_query_species/output_dir

  - id: output_split_fasta_files_query_species
    type: File[]
    outputSource: seqretsplit_query_species/split_fasta_files

  - id: output_dir_hit_species
    type: Directory
    outputSource: seqretsplit_hit_species/output_dir

  - id: output_split_fasta_files_hit_species
    type: File[]
    outputSource: seqretsplit_hit_species/split_fasta_files

  # needle outputs
  - id: output_needle_result_dir
    type: Directory
    outputSource: global_alignment_using_needle/needle_result_dir

  - id: output_needle_result_file
    type: File[]
    outputSource: global_alignment_using_needle/needle_result_file

  # water outputs
  - id: output_water_result_dir
    type: Directory
    outputSource: local_alignment_using_water/water_result_dir

  - id: output_water_result_file
    type: File[]
    outputSource: local_alignment_using_water/water_result_file

# ----------STEPS----------
steps:
  makeblastdb_query_species:
    run: ../Tools/14_makeblastdb.cwl
    in:
      index_dir_name: PARAM_INDEX_DIR_NAME_QUERY_SPECIES
      input_fasta_file: PARAM_INPUT_FASTA_FILE_QUERY_SPECIES
      output_index_name: PARAM_OUTPUT_INDEX_NAME_QUERY_SPECIES
      dbtype: PARAM_DBTYPE
    out: [index_dir, index_file]

  makeblastdb_hit_species:
    run: ../Tools/14_makeblastdb.cwl
    in:
      index_dir_name: PARAM_INDEX_DIR_NAME_HIT_SPECIES
      input_fasta_file: PARAM_INPUT_FASTA_FILE_HIT_SPECIES
      output_index_name: PARAM_OUTPUT_INDEX_NAME_HIT_SPECIES
      dbtype: PARAM_DBTYPE
    out: [index_dir, index_file]

  blastdbcmd_query_species:
    run: ../Tools/15_blastdbcmd.cwl
    in:
      index_files: makeblastdb_query_species/index_file
      entry_batch: PARAM_ENTRY_BATCH_QUERY_SPECIES
      retrieve_result_file_name: PARAM_RETRIEVE_RESULT_FILE_NAME_QUERY_SPECIES
      logfile_name: PARAM_LOGFILE_NAME_QUERY_SPECIES
    out: [blastdbcmd_result, logfile]

  blastdbcmd_hit_species:
    run: ../Tools/15_blastdbcmd.cwl
    in:
      index_files: makeblastdb_hit_species/index_file
      entry_batch: PARAM_ENTRY_BATCH_HIT_SPECIES
      retrieve_result_file_name: PARAM_RETRIEVE_RESULT_FILE_NAME_HIT_SPECIES
      logfile_name: PARAM_LOGFILE_NAME_HIT_SPECIES
    out: [blastdbcmd_result, logfile]

  seqretsplit_query_species:
    run: ../Tools/16_seqretsplit.cwl
    in:
      sequence: blastdbcmd_query_species/blastdbcmd_result
      sformat1: PARAM_SEQUENCE_FORMAT
      output_dir_name: PARAM_OUTPUT_SEQRETSPLIT_DIR_NAME_QUERY_SPECIES
    out: [output_dir, split_fasta_files]

  seqretsplit_hit_species:
    run: ../Tools/16_seqretsplit.cwl
    in:
      sequence: blastdbcmd_hit_species/blastdbcmd_result
      sformat1: PARAM_SEQUENCE_FORMAT
      output_dir_name: PARAM_OUTPUT_SEQRETSPLIT_DIR_NAME_HIT_SPECIES
    out: [output_dir, split_fasta_files]

  global_alignment_using_needle:
    run: ../Tools/17_needle.cwl
    in:
      run_needle_script: NEEDLE_SCRIPT
      foldseek_extract_tsv: PARAM_FOLDSEEK_EXTRACT_TSV
      split_fasta_query_species_dir: seqretsplit_query_species/output_dir
      split_fasta_hit_species_dir: seqretsplit_hit_species/output_dir
      result_needle_dir_name: PARAM_NEEDLE_RESULT_DIR_NAME
      query_col_num: PARAM_ALIGNMENT_QUERY_COL_NUM
      target_col_num: PARAM_ALIGNMENT_TARGET_COL_NUM
    out: [needle_result_dir, needle_result_file]

  local_alignment_using_water:
    run: ../Tools/17_water.cwl
    in:
      run_water_script: WATER_SCRIPT
      foldseek_extract_tsv: PARAM_FOLDSEEK_EXTRACT_TSV
      split_fasta_query_species_dir: seqretsplit_query_species/output_dir
      split_fasta_hit_species_dir: seqretsplit_hit_species/output_dir
      result_water_dir_name: PARAM_WATER_RESULT_DIR_NAME
      query_col_num: PARAM_ALIGNMENT_QUERY_COL_NUM
      target_col_num: PARAM_ALIGNMENT_TARGET_COL_NUM
    out: [water_result_dir, water_result_file]

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/