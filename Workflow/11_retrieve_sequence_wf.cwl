#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
label: "retrieve sequence and perform pairwise alignment (sub-workflow process)"
doc: |
  "Perform pairwise alignment of protein sequences for pairs identified by structural similarity search.
  Step 1: retrieve sequence from blastdbcmd result
  Step 2: makeblastdb: ../Tools/14_makeblastdb.cwl
  Step 3: blastdbcmd: ../Tools/15_blastdbcmd.cwl
  Step 4: seqretsplit: ../Tools/16_seqretsplit.cwl
  Step 5: needle (Global alignment): ../Tools/17_needle.cwl
  Step 6: water (Local alignment): ../Tools/17_water.cwl"

requirements:
  - class: WorkReuse
    enableReuse: true

# ----------WORKFLOW INPUTS----------
inputs:
  # makeblastdb inputs
  - id: INDEX_DIR_NAME_QUERY_SPECIES
    type: string
    label: "index directory name (makeblastdb)"
    doc: "blast index directory name for blastdbcmd"
    format: edam:data_1049
    default: "index_query_species"

  - id: INDEX_DIR_NAME_HIT_SPECIES
    type: string
    label: "index directory name (makeblastdb)"
    doc: "blast index directory name for blastdbcmd"
    format: edam:data_1049
    default: "index_hit_species"
  
  - id: INPUT_FASTA_FILE_QUERY_SPECIES
    type: File
    label: "input fasta file (makeblastdb)"
    doc: "input fasta file for makeblastdb. Retrieve files in advance from uniprot."
    format: edam:format_1929
    default:
      class: File
      format: edam:format_1929
      location: ../test/oryza_sativa_test/uniprotkb_39947_all.fasta

  - id: INPUT_FASTA_FILE_HIT_SPECIES
    type: File
    label: "input fasta file (makeblastdb)"
    doc: "input fasta file for makeblastdb. Retrieve files in advance from uniprot."
    format: edam:format_1929
    default:
      class: File
      format: edam:format_1929
      location: ../test/oryza_sativa_test/uniprotkb_9606_all.fasta

  # blastdbcmd inputs
  - id: ENTRY_BATCH_QUERY_SPECIES
    type: File
    label: "entry batch file (blastdbcmd)"
    doc: "entry batch file for blastdbcmd"
    default:
      class: File
      location: ../test/oryza_sativa_test/foldseek_result_query_species.txt

  - id: ENTRY_BATCH_HIT_SPECIES
    type: File
    label: "entry batch file (blastdbcmd)"
    doc: "entry batch file for blastdbcmd"
    default:
      class: File
      location: ../test/oryza_sativa_test/foldseek_result_hit_species.txt

  - id: BLASTDBCMD_RESULT_FILE_NAME_QUERY_SPECIES
    type: string
    label: "blastdbcmd result file name (blastdbcmd)"
    doc: "blastdbcmd result file name."
    format: edam:data_1050
    default: "blastdbcmd_result_query_species.fasta"

  - id: BLASTDBCMD_LOGFILE_NAME_QUERY_SPECIES
    type: string
    label: "logfile name (blastdbcmd)"
    doc: "logfile name."
    format: edam:data_1050
    default: "blastdbcmd_result_query_species.log"

  - id: BLASTDBCMD_RESULT_FILE_NAME_HIT_SPECIES
    type: string
    label: "blastdbcmd result file name (blastdbcmd)"
    doc: "blastdbcmd result file name."
    format: edam:data_1050
    default: "blastdbcmd_result_hit_species.fasta"

  - id: BLASTDBCMD_LOGFILE_NAME_HIT_SPECIES
    type: string
    label: "logfile name (blastdbcmd)"
    doc: "logfile name."
    format: edam:data_1050
    default: "blastdbcmd_result_hit_species.log"

  # seqretsplit inputs
  - id: SEQRETSPLIT_OUTPUT_DIR_NAME_QUERY_SPECIES
    type: string
    label: "output directory name (seqretsplit)"
    doc: "output directory name for seqretsplit"
    format: edam:data_1049
    default: "split_fasta_query_species"

  - id: SEQRETSPLIT_OUTPUT_DIR_NAME_HIT_SPECIES
    type: string
    label: "output directory name (seqretsplit)"
    doc: "output directory name for seqretsplit"
    format: edam:data_1049
    default: "split_fasta_hit_species"
  
  # needle and water inputs
  # foldseek extract tsv
  - id: NEEDLE_SCRIPT
    type: File
    label: "needle shell script (needle)"
    doc: "needle shell script"
    default:
      class: File
      location: ../scripts/run_needle.sh

  - id: WATER_SCRIPT
    type: File
    label: "water shell script (water)"
    doc: "water shell script"
    default:
      class: File
      location: ../scripts/run_water.sh

  - id: FOLDSEEK_EXTRACT_TSV
    type: File
    label: "foldseek extract tsv (foldseek easy-search)"
    doc: "foldseek extract tsv"
    format: edam:format_3475
    default:
      class: File
      format: edam:format_3475
      location: ../test/oryza_sativa_test/foldseek_os_random_9606.tsv

  - id: NEEDLE_RESULT_DIR_NAME
    type: string
    label: "needle result directory name (needle)"
    doc: "needle result directory name"
    format: edam:data_1049
    default: "result_needle"

  - id: WATER_RESULT_DIR_NAME
    type: string
    label: "water result directory name (water)"
    doc: "water result directory name"
    format: edam:data_1049
    default: "result_water"

  - id: ALIGNMENT_QUERY_COLUMN_NUMBER
    type: int
    label: "alignment query column number (needle and water)"
    doc: "alignment column number (query species) for needle and water. Extract columns describing UniProt ID pairs (query IDs) from the TSV file read with the FOLDSEEK_EXTRACT_TSV parameter"
    default: 1

  - id: ALIGNMENT_TARGET_COLUMN_NUMBER
    type: int
    label: "alignment target column number (needle and water)"
    doc: "alignment column number (target species) for needle and water. Extract columns describing UniProt ID pairs (hit IDs) from the TSV file read with the FOLDSEEK_EXTRACT_TSV parameter"
    default: 2



# ----------OUTPUTS----------
outputs:
  # makeblastdb outputs
  - id: output_index_dir_query_species
    label: "blast index directory (query species)"
    type: Directory
    outputSource: makeblastdb_query_species/index_dir

  - id: output_index_file_query_species
    label: "blast index file (query species)"
    type: File
    outputSource: makeblastdb_query_species/index_file

  - id: output_index_dir_hit_species
    label: "blast index directory (hit species)"
    type: Directory
    outputSource: makeblastdb_hit_species/index_dir

  - id: output_index_file_hit_species
    label: "blast index file (hit species)"
    type: File
    outputSource: makeblastdb_hit_species/index_file

  # blastdbcmd outputs
  - id: output_blastdbcmd_result_query_species
    label: "blastdbcmd result (query species)"
    type: File
    outputSource: blastdbcmd_query_species/blastdbcmd_result

  - id: output_logfile_query_species
    label: "logfile (query species)"
    type: File
    outputSource: blastdbcmd_query_species/logfile

  - id: output_blastdbcmd_result_hit_species
    label: "blastdbcmd result (hit species)"
    type: File
    outputSource: blastdbcmd_hit_species/blastdbcmd_result

  - id: output_logfile_hit_species
    label: "logfile (hit species)"
    type: File
    outputSource: blastdbcmd_hit_species/logfile

  # seqretsplit outputs
  - id: output_dir_query_species
    label: "output directory (query species)"
    type: Directory
    outputSource: seqretsplit_query_species/output_dir

  - id: output_split_fasta_files_query_species
    label: "split fasta files (query species)"
    type: File[]
    outputSource: seqretsplit_query_species/split_fasta_files

  - id: output_dir_hit_species
    label: "output directory (hit species)"
    type: Directory
    outputSource: seqretsplit_hit_species/output_dir

  - id: output_split_fasta_files_hit_species
    label: "split fasta files (hit species)"
    type: File[]
    outputSource: seqretsplit_hit_species/split_fasta_files

  # needle outputs
  - id: output_needle_result_dir
    label: "needle result directory"
    type: Directory
    outputSource: global_alignment_using_needle/needle_result_dir

  - id: output_needle_result_file
    label: "needle result file"
    type: File[]
    outputSource: global_alignment_using_needle/needle_result_file

  # water outputs
  - id: output_water_result_dir
    label: "water result directory"
    type: Directory
    outputSource: local_alignment_using_water/water_result_dir

  - id: output_water_result_file
    label: "water result file"
    type: File[]
    outputSource: local_alignment_using_water/water_result_file

# ----------STEPS----------
steps:
  makeblastdb_query_species:
    run: ../Tools/14_makeblastdb.cwl
    in:
      index_dir_name: INDEX_DIR_NAME_QUERY_SPECIES
      input_fasta_file: INPUT_FASTA_FILE_QUERY_SPECIES
    out:
      - index_dir
      - index_file

  makeblastdb_hit_species:
    run: ../Tools/14_makeblastdb.cwl
    in:
      index_dir_name: INDEX_DIR_NAME_HIT_SPECIES
      input_fasta_file: INPUT_FASTA_FILE_HIT_SPECIES
    out:
      - index_dir
      - index_file

  blastdbcmd_query_species:
    run: ../Tools/15_blastdbcmd.cwl
    in:
      index_files: makeblastdb_query_species/index_file
      entry_batch: ENTRY_BATCH_QUERY_SPECIES
      retrieve_result_file_name: BLASTDBCMD_RESULT_FILE_NAME_QUERY_SPECIES
      logfile_name: BLASTDBCMD_LOGFILE_NAME_QUERY_SPECIES
    out:
      - blastdbcmd_result
      - logfile

  blastdbcmd_hit_species:
    run: ../Tools/15_blastdbcmd.cwl
    in:
      index_files: makeblastdb_hit_species/index_file
      entry_batch: ENTRY_BATCH_HIT_SPECIES
      retrieve_result_file_name: BLASTDBCMD_RESULT_FILE_NAME_HIT_SPECIES
      logfile_name: BLASTDBCMD_LOGFILE_NAME_HIT_SPECIES
    out:
      - blastdbcmd_result
      - logfile

  seqretsplit_query_species:
    run: ../Tools/16_seqretsplit.cwl
    in:
      sequence: blastdbcmd_query_species/blastdbcmd_result
      output_dir_name: SEQRETSPLIT_OUTPUT_DIR_NAME_QUERY_SPECIES
    out:
      - output_dir
      - split_fasta_files

  seqretsplit_hit_species:
    run: ../Tools/16_seqretsplit.cwl
    in:
      sequence: blastdbcmd_hit_species/blastdbcmd_result
      output_dir_name: SEQRETSPLIT_OUTPUT_DIR_NAME_HIT_SPECIES
    out:
      - output_dir
      - split_fasta_files

  global_alignment_using_needle:
    run: ../Tools/17_needle.cwl
    in:
      run_needle_script: NEEDLE_SCRIPT
      foldseek_extract_tsv: FOLDSEEK_EXTRACT_TSV
      split_fasta_query_species_dir: seqretsplit_query_species/output_dir
      split_fasta_hit_species_dir: seqretsplit_hit_species/output_dir
      result_needle_dir_name: NEEDLE_RESULT_DIR_NAME
      query_col_num: ALIGNMENT_QUERY_COLUMN_NUMBER
      target_col_num: ALIGNMENT_TARGET_COLUMN_NUMBER
    out:
      - needle_result_dir
      - needle_result_file

  local_alignment_using_water:
    run: ../Tools/17_water.cwl
    in:
      run_water_script: WATER_SCRIPT
      foldseek_extract_tsv: FOLDSEEK_EXTRACT_TSV
      split_fasta_query_species_dir: seqretsplit_query_species/output_dir
      split_fasta_hit_species_dir: seqretsplit_hit_species/output_dir
      result_water_dir_name: WATER_RESULT_DIR_NAME
      query_col_num: ALIGNMENT_QUERY_COLUMN_NUMBER
      target_col_num: ALIGNMENT_TARGET_COLUMN_NUMBER
    out:
      - water_result_dir
      - water_result_file

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/