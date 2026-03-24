# Oryza sativa ssp.japonica 100 genes Test 🌾 ↔ 🕺

- This directory contains the test results for running the plant2human workflow with *Oryza sativa ssp.japonica* (rice) genes.

## Test Date: 2026-03-22

---

## 📊 Dataset Overview

| Item | Value |
|------|-------|
| **Species** | *Oryza sativa ssp.japonica* |
| **Input genes** | 100 randomly selected genes (Ensembl plants release 62) |
| **Workflow** | `plant2human_v3_stringent.cwl` |
| **Target species** | *Homo sapiens* (Human) |
| **Target Proteome** | [UP000005640](https://www.uniprot.org/proteomes/UP000005640) |
| **AFDB version** | v6 |

--- 

&nbsp;

## 📁 Directory Structure

```bash
tree -L 1

.
├── blastdbcmd_result_query_species.fasta
├── blastdbcmd_result_query_species.log
├── blastdbcmd_result_target_species.fasta
├── blastdbcmd_result_target_species.log
├── foldseek_hit_species_togoid_convert.tsv
├── foldseek_result_gene_level_hit_count_all.tsv
├── foldseek_result_join_alignment_result_all.tsv # <- All result!
├── foldseek_result_join_alignment_result_filter.tsv
├── foldseek_result_pident_lddt.png
├── foldseek_result_query_species.txt
├── foldseek_result_similarity_percent_needle_lddt_all.png
├── foldseek_result_similarity_percent_needle_lddt_filter.png
├── foldseek_result_similarity_percent_water_lddt_all.png
├── foldseek_result_similarity_percent_water_lddt_filter.png
├── foldseek_result_target_species.txt
├── foldseek_target_species_togoid_convert.tsv
├── oryza_sativa_100_genes_uniprot_idmapping.ipynb
├── oryza_sativa_random_100genes_list.tsv
├── os_100_genes_afinfo_json # add .gitignore
├── os_100_genes_idmapping_all.tsv
├── os_100_genes_mmcif # add .gitignore
├── plant2human_report.ipynb # <- All result!
├── README.md
├── result_needle # add .gitignore
├── result_water # add .gitignore
├── split_fasta_query_species # add .gitignore
└── split_fasta_target_species # add .gitignore

6 directories, 21 files
```

---

## How to Reproduce

- Please see [../../README.md](../../README.md)

&nbsp;

## 📚 Related Files

- **YAML parameter file:** [../../job/plant2human_v3_stringent_example_os100.yml](../../job/plant2human_v3_stringent_example_os100.yml)
- 