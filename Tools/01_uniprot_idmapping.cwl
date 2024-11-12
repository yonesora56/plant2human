#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
label: "uniprot id mapping process"
doc: |
  jupyter notebook for UniProt id mapping.

requirements:
  ShellCommandRequirement: {}
  NetworkAccess:
    networkAccess: true
  WorkReuse:
    enableReuse: false

inputs:
  - id: notebook_path
    type: File
    label: "jupyter notebook path"
    doc: "jupyter notebook path. default: ../notebooks/uniprot_idmapping.ipynb"
    default:
      class: File
      format: edam:format_3996
      location: ../notebooks/uniprot_idmapping.ipynb

  - id: output_notebook_name
    type: string
    label: "output notebook name"
    doc: "output notebook name. default: rice_up_uniprot_idmapping.ipynb"
    default: "rice_up_uniprot_idmapping.ipynb"


  - id: gene_id_file
    type: File
    label: "gene id file"
    doc: "gene id file. default: ../Data/Data_HN5_genelist_rice_2402/HN5_genes_up_rice.tsv"
    format: edam:format_3475
    default:
      class: File
      format: edam:format_3475
      location: ../Data/Data_HN5_genelist_rice_2402/HN5_genes_up_rice.tsv


  - id: uniprot_api_query_db
    type: string
    label: "uniprot id mapping query db"
    doc: "uniprot id mapping query db. default: Ensembl_Genomes"
    default: "Ensembl_Genomes"

  - id: uniprot_api_target_db
    type: string
    label: "uniprot id mapping target db"
    doc: "uniprot id mapping target db. default: UniProtKB"
    default: "UniProtKB"

  - id: json_dir_name
    type: string
    label: "json directory name"
    doc: "json directory name. default: rice_up_afinfo_json"
    default: "rice_up_afinfo_json"

  - id: data_url
    type: string
    label: "data url"
    doc: "data url. default: cifUrl (or pdbUrl, bcifUrl, paeImageUrl, paeDocUrl)"
    default: "cifUrl"

  - id: structure_dir_name
    type: string
    label: "structure directory name"
    doc: "structure directory name. default: rice_up_mmcif"
    default: "rice_up_mmcif"

  - id: id_mapping_all_file_name
    type: string
    label: "id mapping all file name"
    doc: "id mapping all file name. default: rice_up_idmapping_all.tsv"
    default: "rice_up_idmapping_all.tsv"

  # - id: unmapped_file_name
  #   type: string
  #   label: "unmapped file name"
  #   doc: "unmapped file name in id mapping process. default: rice_up_unmapped.tsv"
  #   default: "rice_up_unmapped.tsv"

arguments:
  - shellQuote: false
    valueFrom: |
      papermill $(inputs.notebook_path.path) $(inputs.output_notebook_name) \
      -p gene_id_tsv $(inputs.gene_id_file.path) \
      -p query_db $(inputs.uniprot_api_query_db) \
      -p target_db $(inputs.uniprot_api_target_db) \
      -p json_dir $(inputs.json_dir_name) \
      -p data_url $(inputs.data_url) \
      -p structure_dir $(inputs.structure_dir_name) \
      -p id_mapping_all_file $(inputs.id_mapping_all_file_name)

outputs:
  - id: output_notebook
    type: File
    label: "output notebook"
    doc: "output notebook"
    outputBinding:
      glob: "$(inputs.output_notebook_name)"

  - id: json_dir
    type: Directory
    label: "json directory"
    doc: "json directory"
    outputBinding:
      glob: "$(inputs.json_dir_name)"

  - id: json_files
    type: File[]
    label: "json files"
    doc: "json files"
    outputBinding:
      glob: "$(inputs.json_dir_name)/*.json"

  - id: structure_dir
    type: Directory
    label: "structure directory"
    doc: "structure directory"
    outputBinding:
      glob: "$(inputs.structure_dir_name)"

  - id: structure_files
    type: File[]
    label: "structure files"
    doc: "structure files"
    outputBinding:
      glob: "$(inputs.structure_dir_name)/*"

  - id: id_mapping_all_file
    type: File
    label: "id mapping all file"
    doc: "id mapping all file"
    outputBinding:
      glob: "$(inputs.id_mapping_all_file_name)"

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/