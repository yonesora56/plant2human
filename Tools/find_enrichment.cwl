#!/usr/bin/env cwl-runner
# Generated from: find_enrichment.py ./Data/Data_HN5_genelist_rice_2402/HN5_genes_up_rice.txt ./Data/Data_ensembl/rice_all_genelist.txt ./Data/Data_ensembl/rice_go_annotation_r58_concatenated.tsv --pval=0.01 --method=fdr_bh --pval_field=fdr_bh --obo ./Data/go.obo --obsolete=replace --outfile=rice_go_enrichment_up.tsv
class: CommandLineTool
cwlVersion: v1.2
baseCommand: [find_enrichment.py]
arguments:
  - $(inputs.target_genelist)
  - $(inputs.background_genelist)
  - $(inputs.annotation_file)
  - --pval=$(inputs.pvalue)
  - --method=$(inputs.method)
  - --pval_field=$(inputs.pval_field)
  - --obo
  - $(inputs.obo_file)
  - --obsolete=$(inputs.obsolete_go)
  - --outfile=$(inputs.output_file_name)
inputs:
  - id: target_genelist
    label: "Target genelist"
    doc: "Target genelist text file"
    type: File
    default:
      class: File
      location: file:///workspaces/004_foldseek/Data/Data_HN5_genelist_rice_2402/HN5_genes_up_rice.txt
  - id: background_genelist
    label: "Background genelist"
    doc: "Background genelist text file. For example, Data are retrieved from Ensembl Plants release 58."
    type: File
    default:
      class: File
      location: file:///workspaces/004_foldseek/Data/Data_ensembl/rice_all_genelist.txt
  - id: annotation_file
    label: "Gene Ontology annotation file"
    doc: "GO annotation file. default: rice_go_annotation_r58_concatenated.tsv (Ensembl Plants release 58)"
    type: File
    default:
      class: File
      location: file:///workspaces/004_foldseek/Data/Data_ensembl/rice_go_annotation_r58_concatenated.tsv
  - id: pvalue
    label: "P-value threshold"
    doc: "Only print results with uncorrected p-value < PVAL. Print all results, significant and otherwise, by setting --pval=1.0 (default: 0.05)"
    type: float
    default: 0.01
  - id: method
    label: "Multiple testing correction method"
    doc: |
      "Available methods: local( bonferroni sidak holm fdr )
      statsmodels( sm_bonferroni sm_sidak holm_sidak sm_holm
      simes_hochberg hommel fdr_bh fdr_by fdr_tsbh fdr_tsbky
      fdr_gbs ) (default: bonferroni,sidak,holm,fdr_bh)"
    type: string
    default: "fdr_bh"
  - id: pval_field
    label: "P-value field"
    doc: "Only print results when PVAL_FIELD < PVAL. (default: None)"
    type: string
    default: "fdr_bh"
  - id: obo_file
    label: "OBO formatfile"
    doc: |
      "Specifies location and name of the obo file (default: go-basic.obo). OBO foundry access: 2024/10/02"
    type: File
    format: edam:format_2549
    default:
      class: File
      format: edam:format_2549
      location: file:///workspaces/004_foldseek/Data/go.obo
  - id: obsolete_go
    label: "Strategy for handling obsolete GO terms"
    doc: "keep,replace,skip. (in this CWL file, default is replace)"
    type: string
    default: "replace"
  - id: output_file_name
    label: "Output file name"
    doc: "Output file name (default: rice_go_enrichment_up.tsv)"
    type: string
    default: "rice_go_enrichment_up.tsv"
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
stdout: find_enrichment_stdout.txt

# hints: (no corresponding version in the container registry)
#   - class: DockerRequirement
#     dockerPull: quay.io/biocontainers/goatools:1.2.3--pyh7cba7a3_2

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/