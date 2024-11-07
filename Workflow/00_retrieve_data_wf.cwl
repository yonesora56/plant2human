#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
label: "retrieve data workflow"
doc: |
  uniprot id mapping ../Tools/01_uniprot_idmapping.cwl


# ----------WORKFLOW INPUTS----------

inputs:
  - id: PYTHON_SCRIPT_FOR_IDMAPPING
    type: File
    doc: "python script for id mapping (using polars, unipressed)"
    format: edam:format_3996
    default:
      class: File
      format: edam:format_3996
      location: file:///workspaces/004_foldseek/scripts/uniprot_idmapping.py
  - id: GENE_LIST
    type: File
    doc: "gene list for id mapping"
    format: edam:format_3475
    default:
      class: File
      format: edam:format_3475
      location: file:///workspaces/004_foldseek/test/HN5_genes_up_rice.tsv
  - id: OUTPUT_FILE_NAME_FOR_IDMAPPING
    type: string
    default: HN5_genes_up_rice_mapping.tsv
  - id: TARGET_COLUMN_FOR_IDMAPPING
    type: string
    default: "From"
  - id: UNMAPPED_LIST_FILE_NAME
    type: string
    default: HN5_genes_up_rice_unmapping_list.tsv
  - id: FROM_DB_FOR_IDMAPPING
    type: string
    default: "Ensembl_Genomes"
  - id: TO_DB_FOR_IDMAPPING
    type: string
    default: "UniProtKB"


# ----------OUTPUTS----------
outputs:
  - id: IDMAPPING_RESULT
    type: File
    outputSource: uniprot_idmapping/idmapping_result

  - id: UNMAPPED_LIST
    type: File
    outputSource: uniprot_idmapping/unmapped_list

# ----------STEPS----------
steps:
  uniprot_idmapping:
    run: ../Tools/01_uniprot_idmapping.cwl
    in:
      python_script_for_idmapping: PYTHON_SCRIPT_FOR_IDMAPPING
      input: GENE_LIST
      output_name: OUTPUT_FILE_NAME_FOR_IDMAPPING
      column: TARGET_COLUMN_FOR_IDMAPPING
      unmapped_list_name: UNMAPPED_LIST_FILE_NAME
      from_db: FROM_DB_FOR_IDMAPPING
      to_db: TO_DB_FOR_IDMAPPING
    out:
      - idmapping_result
      - unmapped_list

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/