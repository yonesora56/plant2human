#!/usr/bin/env cwl-runner
# Generated from: papermill ./notebooks/foldseek_result_parse.ipynb ./plant2human_report.ipynb -p foldseek_result_tsv ./out/rice_up/foldseek_rice_up_9606.tsv -p rice_uniprot_idmapping_tsv ./out/rice_up/rice_up_idmapping.tsv -p water_result_dir_path ./out/rice_up/water_result -p needle_result_dir_path ./out/rice_up/needle_result -p gene_list_tsv_path ./Data/Data_HN5_genelist_rice_2402/HN5_genes_up_rice.tsv -p togoid_convert_tsv_path ./out/rice_up/rice_up_togoid_convert.tsv
class: CommandLineTool
cwlVersion: v1.2
label: "papermill execution"
doc: "papermill execution for plant2human notebook report. This notebook includes a scatterplot of structural similarity vs. sequence similarity, etc. It can be customized according to the user's needs."
  

requirements:
  ShellCommandRequirement: {}

inputs:
  - id: foldseek_result_parse_notebook
    type: File
    label: "jupyter notebook for parse workflow results so far"
    doc: "jupyter notebook for parse workflow results so far (default: ../notebooks/foldseek_result_parse.ipynb)"
    default:
      class: File
      location: ../notebooks/foldseek_result_parse.ipynb

  - id: report_notebook_name
    type: string
    label: "output notebook name"
    doc: "output notebook name (default: plant2human_report.ipynb)"
    default: "plant2human_report.ipynb"

  - id: foldseek_result_tsv
    type: File
    format: edam:format_3475
    label: "foldseek result tsv file"
    doc: "foldseek result tsv file. Before executing, please make sure that you have already completed the execution with “12_extract_target_species.cwl”. (default: ../test/workflow_test/foldseek_rice_up_9606.tsv)"
    default:
      class: File
      format: edam:format_3475
      location: ../test/oryza_sativa_test/foldseek_os_random_9606.tsv

  - id: query_uniprot_idmapping_tsv
    type: File
    format: edam:format_3475
    label: "query uniprot idmapping tsv file"
    doc: "query uniprot idmapping tsv file. Before executing, please make sure that you have already completed the uniprot idmapping process. (default: ../test/workflow_test/rice_up_idmapping.tsv)"
    default:
      class: File
      format: edam:format_3475
      location: ../test/oryza_sativa_test/rice_up_idmapping.tsv

  - id: water_result_dir
    type: Directory
    label: "water result directory"
    doc: "water result directory. Before executing, please make sure that you have already completed the water process. (default: ../test/workflow_test/result_water/)"
    default:
      class: Directory
      location: ../test/oryza_sativa_test/result_water/
    
  - id: needle_result_dir
    type: Directory
    label: "needle result directory"
    doc: "needle result directory. Before executing, please make sure that you have already completed the needle process. (default: ../test/workflow_test/result_needle/)"
    default:
      class: Directory
      location: ../test/oryza_sativa_test/result_needle/

  - id: query_gene_list_tsv
    type: File
    format: edam:format_3475
    label: "query gene list tsv file"
    doc: "query gene list tsv file. Before executing, please make sure that you have already completed the execution with “12_extract_target_species.cwl”. (default: ../test/workflow_test/HN5_genes_up_rice.tsv)"
    default:
      class: File
      format: edam:format_3475
      location: ../test/oryza_sativa_test/HN5_genes_up_rice.tsv

  - id: togoid_convert_tsv
    type: File
    format: edam:format_3475
    label: "togoid convert tsv file"
    doc: "togoid convert tsv file. Before executing, please make sure that you have already completed the execution with “18_togoid_convert.cwl”. (default: ../test/workflow_test/foldseek_hit_species_togoid_convert.tsv)"
    default:
      class: File
      format: edam:format_3475
      location: ../test/oryza_sativa_test/foldseek_hit_species_togoid_convert.tsv

arguments:
  - shellQuote: false
    valueFrom: |
      papermill $(inputs.foldseek_result_parse_notebook.path) $(inputs.report_notebook_name) \
      -p foldseek_result_tsv $(inputs.foldseek_result_tsv.path) \
      -p query_uniprot_idmapping_tsv $(inputs.query_uniprot_idmapping_tsv.path) \
      -p water_result_dir_path $(inputs.water_result_dir.path) \
      -p needle_result_dir_path $(inputs.needle_result_dir.path) \
      -p query_gene_list_tsv_path $(inputs.query_gene_list_tsv.path) \
      -p togoid_convert_tsv_path $(inputs.togoid_convert_tsv.path)


outputs:
  - id: report_notebook
    type: File
    label: "output notebook"
    doc: "output notebook (default: plant2human_report.ipynb). Users can customize the notebook according to their needs."
    outputBinding:
      glob: "$(inputs.report_notebook_name)"

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/