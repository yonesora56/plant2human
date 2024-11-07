#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
label: "foldseek easy-search workflow"
doc: |
  foldseek easy search workflow
  listing files: ../Tools/10_listing.cwl
  foldseek easy search: ../Tools/11_foldseek_easy_search.cwl
  extract target species: ../Tools/12_extract_target_species.cwl
  sub-workflow: ./11_retrieve_sequence_wf.cwl
  togoid convert: ../Tools/18_togoid_convert.cwl

requirements:
  - class: WorkReuse
    enableReuse: true
  - class: SubworkflowFeatureRequirement

# ----------WORKFLOW INPUTS----------
inputs:
  # listing files
  - id: INPUT_DIRECTORY
    doc: "query protein structure file directory"
    type: Directory
    default:
      class: Directory
      location: ../out/rice_up/rice_up_mmcif/

  # - id: FILE_MATCH_PATTERN
  #   doc: "file match pattern for listing"
  #   type: string
  #   default: "*.cif"
  
  - id: INDEX_FOR_SEARCH
    doc: "search index file"
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

  - id: OUTPUT_FILE_NAME
    type: string
    default: "foldseek_output_uniprot_up_all_evalue01.tsv"

  - id: PARAM_EVALUE
    type: double
    default: 0.1

  - id: PARAM_THREADS
    type: int
    default: 16

  - id: PARAM_SPLIT_MEMORY_LIMIT
    type: string
    default: "120G"

  - id: PARAM_INPUT_FORMAT
    type: int
    default: 2

  - id: PARAM_TAXONOMY_ID_LIST
    type: string
    default: "9606,10090,3702,4577,4529"
  

  - id: PARAM_HIT_TAXONOMY_ID
    type: int
    default: 9606
  
  - id: PARAM_OUTPUT_FILE_NAME
    type: string
    default: "foldseek_rice_up_9606.tsv"
  
  - id: PARM_COLUMN_NUMBER_QUERY_SPECIES
    type: int
    default: 1
  
  - id: PARAM_OUTPUT_FILE_NAME_QUERY_SPECIES
    type: string
    default: "foldseek_result_query_species.txt"

  - id: PARAM_COLUMN_NUMBER_HIT_SPECIES
    type: int
    default: 2
  
  - id: PARAM_OUTPUT_FILE_NAME_HIT_SPECIES
    type: string
    default: "foldseek_result_hit_species.txt"

  # sub-workflow retrieve sequence inputs (makeblastdb)
  - id: SW_PARAM_INPUT_FASTA_FILE_QUERY_SPECIES
    type: File
    doc: "input fasta file"
    format: edam:format_1332
    default:
      class: File
      format: edam:format_1332
      location: ../Data/Data_uniprot/FASTA_for_index/uniprotkb_rice_all_240820.fasta

  - id: SW_PARAM_INPUT_FASTA_FILE_HIT_SPECIES
    type: File
    doc: "input fasta file"
    format: edam:format_1332
    default:
      class: File
      format: edam:format_1332
      location: ../Data/Data_uniprot/FASTA_for_index/uniprotkb_human_all_241107.fasta

  # - id: SW_PARAM_ALIGNMENT_QUERY_COL_NUM
  #   type: int
  #   default: 1

  # - id: SW_PARAM_ALIGNMENT_TARGET_COL_NUM
  #   type: int
  #   default: 2
  
  # togoid convert process
  - id: TOGOID_CONVERT_OUTPUT_FILE_NAME
    type: string
    default: "foldseek_hit_species_togoid_convert.tsv"


# ----------OUTPUTS----------
outputs:

  - id: output_file
    type: File
    format: edam:format_3475
    outputSource: foldseek_easy_search/all

  - id: output_file_target_species
    type: File
    format: edam:format_3475
    outputSource: extract_target_species/output_extract_file
  
  - id: output_file_query_species
    type: File
    outputSource: extract_query_species_column/output_file

  - id: output_file_hit_species
    type: File
    format: edam:format_3475
    outputSource: extract_hit_species_column/output_file
  
  # sub-workflow retrieve sequence outputs (makeblastdb)
  - id: sw_output_index_dir_query_species
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_index_dir_query_species

  - id: sw_output_index_file_query_species
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_index_file_query_species

  - id: sw_output_index_dir_hit_species
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_index_dir_hit_species

  - id: sw_output_index_file_hit_species
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_index_file_hit_species

  # sub-workflow retrieve sequence outputs (blastdbcmd)
  - id: sw_output_blastdbcmd_result_query_species
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_blastdbcmd_result_query_species

  - id: sw_output_blastdbcmd_result_hit_species
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_blastdbcmd_result_hit_species

  - id: sw_output_logfile_query_species
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_logfile_query_species

  - id: sw_output_logfile_hit_species
    type: File
    outputSource: sub_workflow_retrieve_sequence_query_species/output_logfile_hit_species

  # sub-workflow retrieve sequence outputs (seqretsplit)
  - id: sw_output_dir_query_species
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_dir_query_species

  - id: sw_output_split_fasta_files_query_species
    type: File[]
    outputSource: sub_workflow_retrieve_sequence_query_species/output_split_fasta_files_query_species

  - id: sw_output_dir_hit_species
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_dir_hit_species

  - id: sw_output_split_fasta_files_hit_species
    type: File[]
    outputSource: sub_workflow_retrieve_sequence_query_species/output_split_fasta_files_hit_species

  # sub-workflow retrieve sequence outputs (needle)
  - id: sw_output_needle_result_dir
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_needle_result_dir

  - id: sw_output_needle_result_file
    type: File[]
    outputSource: sub_workflow_retrieve_sequence_query_species/output_needle_result_file

  # sub-workflow retrieve sequence outputs (water)
  - id: sw_output_water_result_dir
    type: Directory
    outputSource: sub_workflow_retrieve_sequence_query_species/output_water_result_dir

  - id: sw_output_water_result_file
    type: File[]
    outputSource: sub_workflow_retrieve_sequence_query_species/output_water_result_file

  - id: togoid_convert_output_file
    type: File
    outputSource: togoid_convert/output_file

# ----------STEPS----------
steps:
  list_files:
    run: ../Tools/10_listing.cwl
    in:
      glob_root: INPUT_DIRECTORY
      # glob_pattern: FILE_MATCH_PATTERN
    out:
      - files

  foldseek_easy_search:
    run: ../Tools/11_foldseek_easy_search.cwl
    in:
      mmcif_file: list_files/files
      index: INDEX_FOR_SEARCH
      output_file_name: OUTPUT_FILE_NAME
      e_value: PARAM_EVALUE
      threads: PARAM_THREADS
      split_memory_limit: PARAM_SPLIT_MEMORY_LIMIT
      input_file_format: PARAM_INPUT_FORMAT
      taxonomy_id_list: PARAM_TAXONOMY_ID_LIST
    out:
      - all

  extract_target_species:
    run: ../Tools/12_extract_target_species.cwl
    in:
      input_file: foldseek_easy_search/all
      target_species: PARAM_HIT_TAXONOMY_ID
      output_file_name: PARAM_OUTPUT_FILE_NAME
    out:
      - output_extract_file
  
  extract_query_species_column:
    run: ../Tools/13_extract_id.cwl
    in:
      tsvfile: extract_target_species/output_extract_file
      column_number: PARM_COLUMN_NUMBER_QUERY_SPECIES
      output_file_name: PARAM_OUTPUT_FILE_NAME_QUERY_SPECIES
    out:
      - output_file

  extract_hit_species_column:
    run: ../Tools/13_extract_id.cwl
    in:
      tsvfile: extract_target_species/output_extract_file
      column_number: PARAM_COLUMN_NUMBER_HIT_SPECIES
      output_file_name: PARAM_OUTPUT_FILE_NAME_HIT_SPECIES
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
      PARAM_INPUT_FASTA_FILE_QUERY_SPECIES: SW_PARAM_INPUT_FASTA_FILE_QUERY_SPECIES
      PARAM_INPUT_FASTA_FILE_HIT_SPECIES: SW_PARAM_INPUT_FASTA_FILE_HIT_SPECIES
      PARAM_ENTRY_BATCH_QUERY_SPECIES: extract_query_species_column/output_file # workflow output
      PARAM_ENTRY_BATCH_HIT_SPECIES: extract_hit_species_column/output_file # workflow output
      PARAM_FOLDSEEK_EXTRACT_TSV: extract_target_species/output_extract_file # workflow output
      PARAM_ALIGNMENT_QUERY_COL_NUM: PARM_COLUMN_NUMBER_QUERY_SPECIES
      PARAM_ALIGNMENT_TARGET_COL_NUM: PARAM_COLUMN_NUMBER_HIT_SPECIES
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
      id_convert_file: extract_hit_species_column/output_file
      output_file_name: TOGOID_CONVERT_OUTPUT_FILE_NAME
    out:
      - output_file

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/
