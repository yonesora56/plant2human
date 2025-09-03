#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
label: "retrieve sequence and perform pairwise alignment (sub-workflow process)"
doc: |
  "Perform pairwise alignment of protein sequences for pairs identified by structural similarity search.
  Step 1: retrieve sequence from blastdbcmd result
  Step 2: blastdbcmd: ../Tools/15_blastdbcmd_v2.cwl
  Step 3: seqretsplit: ../Tools/16_seqretsplit.cwl
  Step 4: needle (Global alignment): ../Tools/17_needle_v2.cwl
  Step 5: water (Local alignment): ../Tools/17_water_v2.cwl
  "

requirements:
  - class: WorkReuse
    enableReuse: true

# ----------WORKFLOW INPUTS----------
inputs:
  # blastdbcmd inputs
  - id: BLAST_INDEX_FILES
    type: File
    label: "blast index files (blastdbcmd)"
    doc: "blast index files for blastdbcmd"
    default:
      class: File
      location: ../index/index_uniprot_afdb_all_sequences/afdb_all_sequences.fasta
    secondaryFiles:
      - .00.phd
      - .00.phi
      - .00.phr
      - .00.pin
      - .00.pog
      - .00.psq
      - .01.phd
      - .01.phi
      - .01.phr
      - .01.pin
      - .01.pog
      - .01.psq
      - .02.phd
      - .02.phi
      - .02.phr
      - .02.pin
      - .02.pog
      - .02.psq
      - .03.phd
      - .03.phi
      - .03.phr
      - .03.pin
      - .03.pog
      - .03.psq
      - .04.phd
      - .04.phi
      - .04.phr
      - .04.pin
      - .04.pog
      - .04.psq
      - .05.phd
      - .05.phi
      - .05.phr
      - .05.pin
      - .05.pog
      - .05.psq
      - .06.phd
      - .06.phi
      - .06.phr
      - .06.pin
      - .06.pog
      - .06.psq
      - .07.phd
      - .07.phi
      - .07.phr
      - .07.pin
      - .07.pog
      - .07.psq
      - .08.phd
      - .08.phi
      - .08.phr
      - .08.pin
      - .08.pog
      - .08.psq
      - .09.phd
      - .09.phi
      - .09.phr
      - .09.pin
      - .09.pog
      - .09.psq
      - .10.phd
      - .10.phi
      - .10.phr
      - .10.pin
      - .10.pog
      - .10.psq
      - .11.phd
      - .11.phi
      - .11.phr
      - .11.pin
      - .11.pog
      - .11.psq
      - .12.phd
      - .12.phi
      - .12.phr
      - .12.pin
      - .12.pog
      - .12.psq
      - .13.phd
      - .13.phi
      - .13.phr
      - .13.pin
      - .13.pog
      - .13.psq
      - .14.phd
      - .14.phi
      - .14.phr
      - .14.pin
      - .14.pog
      - .14.psq
      - .15.phd
      - .15.phi
      - .15.phr
      - .15.pin
      - .15.pog
      - .15.psq
      - .16.phd
      - .16.phi
      - .16.phr
      - .16.pin
      - .16.pog
      - .16.psq
      - .17.phd
      - .17.phi
      - .17.phr
      - .17.pin
      - .17.pog
      - .17.psq
      - .18.phd
      - .18.phi
      - .18.phr
      - .18.pin
      - .18.pog
      - .18.psq
      - .19.phd
      - .19.phi
      - .19.phr
      - .19.pin
      - .19.pog
      - .19.psq
      - .20.phd
      - .20.phi
      - .20.phr
      - .20.pin
      - .20.pog
      - .20.psq
      - .21.phd
      - .21.phi
      - .21.phr
      - .21.pin
      - .21.pog
      - .21.psq
      - .22.phd
      - .22.phi
      - .22.phr
      - .22.pin
      - .22.pog
      - .22.psq
      - .23.phd
      - .23.phi
      - .23.phr
      - .23.pin
      - .23.pog
      - .23.psq
      - .pal
      - .pdb
      - .pjs
      - .pos
      - .pot
      - .ptf
      - .pto


  - id: ENTRY_BATCH_QUERY_SPECIES
    type: File
    label: "entry batch file (blastdbcmd)"
    doc: "entry batch file for blastdbcmd"
    default:
      class: File
      location: ../test/oryza_sativa_test_202509/foldseek_result_query_species.txt

  - id: ENTRY_BATCH_HIT_SPECIES
    type: File
    label: "entry batch file (blastdbcmd)"
    doc: "entry batch file for blastdbcmd"
    default:
      class: File
      location: ../test/oryza_sativa_test_202509/foldseek_result_hit_species.txt

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
  - id: FOLDSEEK_EXTRACT_TSV
    type: File
    label: "foldseek extract tsv (foldseek easy-search)"
    doc: "foldseek extract tsv"
    format: edam:format_3475
    default:
      class: File
      format: edam:format_3475
      location: ../test/oryza_sativa_test_202509/foldseek_os_random_9606.tsv

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
  blastdbcmd_query_species:
    run: ../Tools/15_blastdbcmd_v2.cwl
    in:
      index_files: BLAST_INDEX_FILES
      entry_batch: ENTRY_BATCH_QUERY_SPECIES
      retrieve_result_file_name: BLASTDBCMD_RESULT_FILE_NAME_QUERY_SPECIES
      logfile_name: BLASTDBCMD_LOGFILE_NAME_QUERY_SPECIES
    out:
      - blastdbcmd_result
      - logfile

  blastdbcmd_hit_species:
    run: ../Tools/15_blastdbcmd_v2.cwl
    in:
      index_files: BLAST_INDEX_FILES
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
    run: ../Tools/17_needle_v2.cwl
    in:
      # run_needle_script: default
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
    run: ../Tools/17_water_v2.cwl
    in:
      # run_water_script: default
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