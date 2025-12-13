#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
id: plant2human_v3
label: "plant2human main workflow"
doc: |
  "
  plant2human main workflow: compare structural similarity and sequence similarity
  Compare distantly related species, such as plants and humans, using measures of structural similarity and sequence similarity.
  This workflow will contribute to the discovery of protein-coding genes with features that are “low sequence similarity but high structural similarity”.
  "

# ----------WORKFLOW METADATA----------
$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0004-1874-3117
    s:email: d246887@hiroshima-u.ac.jp
    s:name: Sora Yonezawa

s:codeRepository: https://github.com/yonesora56/plant2human
s:dateCreated: "2024-11-13"
s:dateModified: "2025-12-12"
s:license: https://spdx.org/licenses/MIT
s:keywords:
  - "Functional Annotation"
  - "alphafold"
  - "protein structure"

# ----------WORKFLOW REQUIREMENTS----------
requirements:
  - class: WorkReuse
    enableReuse: true
  - class: SubworkflowFeatureRequirement
  - class: NetworkAccess
    networkAccess: true


# ----------WORKFLOW INPUTS----------
inputs:
  # foldseek easy-search sub-workflow inputs
  - id: INPUT_DIRECTORY
    label: "input protein structure files directory"
    doc: "query protein structure file (default: mmCIF) directory for foldseek easy-search input."
    type: Directory
    default:
      class: Directory
      location: ../test/oryza_sativa_test_100genes_202512/os_100_genes_mmcif/

  - id: FILE_MATCH_PATTERN
    label: "structure file match pattern"
    doc: "file match pattern for listing input files. default: *.cif"
    type: string
    default: "*.cif"
  
  - id: FOLDSEEK_INDEX
    label: "foldseek index files"
    doc: |
      "foldseek index files for foldseek easy-search input. default: ../index/index_swissprot/swissprot
      Note: At this time (2025/02/02), the process of acquiring and indexing index files for execution has not been incorporated into the workflow.
      Therefore, we would like you to execute the following commands in advance.
      example: `foldseek databases Alphafold/Swiss-Prot index_swissprot/swissprot tmp --threads 8`
      "
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

  - id: ALIGNMENT_TYPE
    label: "alignment type (foldseek easy-search)"
    doc: "alignment type for foldseek easy-search. default: 2 (3Di + AA: local alignment) for detailed information, see foldseek GitHub repository."
    type: int
    default: 2

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

  - id: TAXONOMY_ID_LIST
    label: "taxonomy id list (foldseek easy-search)"
    doc: "taxonomy id list. separated by comma. Be sure to set “9606”. default: 9606 (human), 10090 (mouse), 3702 (Arabidopsis), 4577 (Zea mays), 4529 (Oryza rufipogon)"
    type: string
    default: "9606,10090,3702,4577,4529"
  
  # 12_extract_target_species_v2.cwl
  - id: OUTPUT_FILE_NAME2
    label: "output file name (extract target species)"
    doc: "output file name for extract target species (default: human) python script."
    format: edam:data_1050
    type: string
    default: "foldseek_os_random_9606.tsv"
  
  # 13_extract_id.cwl
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

  # 11_retrieve_sequence_wf_v2.cwl
  - id: BLAST_INDEX_FILES
    type: File
    label: "blast index files (blastdbcmd)"
    doc: "blast index files for blastdbcmd"
    default:
      class: File
      location: ../index/index_uniprot_afdb_all_sequences_v6/afdb_all_sequences_v6.fasta
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
      # === ADD NEW PARTITIONS ===
      - .24.phd
      - .24.phi
      - .24.phr
      - .24.pin
      - .24.pog
      - .24.psq
      - .25.phd
      - .25.phi
      - .25.phr
      - .25.pin
      - .25.pog
      - .25.psq
      - .26.phd
      - .26.phi
      - .26.phr
      - .26.pin
      - .26.pog
      - .26.psq
      # === END NEW PARTITIONS ===
      - .pal
      - .pdb
      - .pjs
      - .pos
      - .pot
      - .ptf
      - .pto

  # togoid convert process
  - id: ROUTE_DATASET
    label: "route dataset (ID conversion using togoID)"
    doc: "route dataset for ID conversion. This operation selects the UniProt ID of the target species (human) for which cross-references exist (final destination is HGNC gene symbol). default: uniprot,ensembl_protein,ensembl_transcript,ensembl_gene,hgnc,hgnc_symbol"
    type: string
    default: "uniprot,ensembl_protein,ensembl_transcript,ensembl_gene,hgnc,hgnc_symbol"

  - id: OUTPUT_FILE_NAME3
    label: "output file name (ID conversion using togoID)"
    doc: "output file name for ID conversion. default: foldseek_hit_species_togoid_convert.tsv"
    format: edam:data_1050
    type: string
    default: "foldseek_hit_species_togoid_convert.tsv"

  # papermill process
  - id: OUT_NOTEBOOK_NAME
    label: "output notebook name (papermill process)"
    doc: "output notebook name for papermill.  After the analysis workflow is output, it can be freely customized such as changing the parameter values. default: plant2human_report.ipynb"
    format: edam:data_1050
    type: string
    default: "plant2human_report.ipynb"

  - id: QUERY_IDMAPPING_TSV
    label: "query idmapping tsv (papermill process)"
    doc: "query idmapping tsv file. Retrieve files in advance. default: rice UniProt ID mapping file"
    type: File
    format: edam:format_3475
    default:
      class: File
      format: edam:format_3475
      location: ../test/oryza_sativa_test_202509/rice_random_gene_idmapping_all.tsv

  - id: QUERY_GENE_LIST_TSV
    label: "query gene list tsv (papermill process)"
    doc: "query gene list tsv file. Retrieve files in advance. default: rice random gene list"
    type: File
    format: edam:format_3475
    default:
      class: File
      format: edam:format_3475
      location: ../test/oryza_sativa_test_202509/oryza_sativa_random_gene_list.tsv

# ----------OUTPUTS----------
outputs:

  - id: TSVFILE1
    label: "output file (foldseek easy-search result)"
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
    doc: |
      "Execute foldseek easy-search using foldseek using BioContainers docker image. This workflow supports only TSV file output.
      Step 1: listing files
      Step 2: foldseek easy-search process"
    run: ./10_foldseek_easy_search_swf_permissive.cwl
    in:
      INPUT_DIRECTORY: INPUT_DIRECTORY
      FILE_MATCH_PATTERN: FILE_MATCH_PATTERN
      FOLDSEEK_INDEX: FOLDSEEK_INDEX
      OUTPUT_FILE_NAME1: OUTPUT_FILE_NAME1
      EVALUE: EVALUE
      ALIGNMENT_TYPE: ALIGNMENT_TYPE
      # FORMAT_MODE: default
      # FORMAT_OUTPUT: default
      THREADS: THREADS
      SPLIT_MEMORY_LIMIT: SPLIT_MEMORY_LIMIT
      # PARAM_INPUT_FORMAT: default
      TAXONOMY_ID_LIST: TAXONOMY_ID_LIST
    out:
      - tsvfile

  extract_target_species:
    label: "extract target species (human) process"
    doc: "Extract target species (human) from foldseek easy-search result. execute: ../Tools/12_extract_target_species.cwl"
    run: ../Tools/12_extract_target_species.cwl
    in:
      # extract_target_species_py: default
      input_file: sub_workflow_foldseek_easy_search/tsvfile # workflow input
      # target_species: default (9606)
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
      "Perform pairwise alignment of protein sequences for pairs identified by structural similarity search.
      Step 1: retrieve sequence from blastdbcmd result
      Step 2: blastdbcmd: ../Tools/14_blastdbcmd.cwl
      Step 3: seqretsplit: ../Tools/15_seqretsplit.cwl
      Step 4: needle (Global alignment): ../Tools/16_needle.cwl
      Step 5: water (Local alignment): ../Tools/16_water.cwl
      "

    run: ./11_retrieve_sequence_swf.cwl
    in:
      BLAST_INDEX_FILES: BLAST_INDEX_FILES
      ENTRY_BATCH_QUERY_SPECIES: extract_query_species_column/output_file # workflow input
      ENTRY_BATCH_HIT_SPECIES: extract_hit_species_column/output_file # workflow input
      # BLASTDBCMD_RESULT_FILE_NAME_QUERY_SPECIES: default
      # BLASTDBCMD_LOGFILE_NAME_QUERY_SPECIES: default
      # BLASTDBCMD_RESULT_FILE_NAME_HIT_SPECIES: default
      # BLASTDBCMD_LOGFILE_NAME_HIT_SPECIES: default
      # SEQRETSPLIT_OUTPUT_DIR_NAME_QUERY_SPECIES: default
      # SEQRETSPLIT_OUTPUT_DIR_NAME_HIT_SPECIES: default
      FOLDSEEK_EXTRACT_TSV: extract_target_species/output_extract_file # workflow input
      # NEEDLE_RESULT_DIR_NAME: default
      # WATER_RESULT_DIR_NAME: default
      ALIGNMENT_QUERY_COLUMN_NUMBER: WF_COLUMN_NUMBER_QUERY_SPECIES
      ALIGNMENT_TARGET_COLUMN_NUMBER: WF_COLUMN_NUMBER_HIT_SPECIES
    out:
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
    doc: "retrieve UniProt ID to HGNC gene symbol using togoID python script. execute: ../Tools/18_togoid_convert.cwl"
    run: ../Tools/17_togoid_convert.cwl
    in:
      # togoid_convert_script: default
      id_convert_file: extract_hit_species_column/output_file # workflow input
      route_dataset: ROUTE_DATASET
      output_file_name: OUTPUT_FILE_NAME3
    out:
      - output_file

  papermill:
    label: "papermill process"
    doc: "output notebook using papermill. This process allows you to create a scatter plot of structural similarity vs. sequence similarity. execute: ../Tools/19_papermill.cwl"
    run: ../Tools/18_papermill.cwl
    in:
      # foldseek_result_parse_notebook: default
      report_notebook_name: OUT_NOTEBOOK_NAME
      foldseek_result_tsv: extract_target_species/output_extract_file # workflow input
      query_uniprot_idmapping_tsv: QUERY_IDMAPPING_TSV
      water_result_dir: sub_workflow_retrieve_sequence_query_species/output_water_result_dir # workflow input
      needle_result_dir: sub_workflow_retrieve_sequence_query_species/output_needle_result_dir # workflow input
      query_gene_list_tsv: QUERY_GENE_LIST_TSV 
      togoid_convert_tsv: togoid_convert/output_file # workflow input
    out:
      - report_notebook