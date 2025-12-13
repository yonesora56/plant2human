# Zey mays 100 Genes Test 🌽 ↔ 🕺

This directory contains the test results for running the plant2human workflow with *Arabidopsis thaliana* (thale cress) genes.

**Test Date:** 2025-12-13

---

## 📊 Dataset Overview

| Item | Value |
|------|-------|
| **Species** | *Zea mays* |
| **Input genes** | 100 randomly selected genes (Ensembl plants release 62) |
| **Workflow** | `plant2human_v3_stringent.cwl` |
| **Target species** | *Homo sapiens* (Human) |
| **Proteome** | [UP000005640](https://www.uniprot.org/proteomes/UP000005640) |
| **AFDB version** | v6 |

---

&nbsp;

## 📁 Directory Structure

```bash
tree -L 1
.
├── README.md # This file
├── blastdbcmd_result_hit_species.fasta # Step 1 notebook
├── blastdbcmd_result_hit_species.log # Input gene list
├── blastdbcmd_result_query_species.fasta 
├── blastdbcmd_result_query_species.log
├── foldseek_hit_species_togoid_convert_stringent.tsv
├── foldseek_output_human_proteome_v6_zm_100genes_evalue01_stringent.tsv
├── foldseek_result_hit_species_stringent.txt
├── foldseek_result_query_species_stringent.txt
├── foldseek_zm_100genes_9606_stringent.tsv
├── result_needle/ # Global alignment results (add .gitignore)
├── result_water/ # Local alignment results (add .gitignore)
├── split_fasta_hit_species/ # Individual FASTA files (hit) (add .gitignore)
├── split_fasta_query_species/ # Individual FASTA files (query) (add .gitignore)
├── zea_mays_100_genes_uniprot_idmapping.ipynb
├── zea_mays_random_100genes_list.tsv
├── zm_100_genes_afinfo_json/ # AlphaFold info JSON files
├── zm_100_genes_idmapping_all.tsv # ID mapping results
├── zm_100_genes_mmcif/ # Structure files (mmCIF) (add .gitignore)
└── zm_100_genes_plant2human_report_stringent.ipynb # Final report (add .gitignore)

6 directories, 14 files
```

---

&nbsp;

## How to Reproduce

### Step 1: UniProt ID Mapping

```bash
# test date: 2025-12-13
cwltool --debug --outdir ./test/zea_mays_test_100genes_202512/ \
./Tools/01_uniprot_idmapping.cwl \
./job/at_100genes_uniprot_idmapping.yml
```

### Step 2: Main Workflow (Stringent Mode)

```bash
# test date: 2025-12-13
cwltool --debug --outdir ./test/zea_mays_test_100genes_202512/ \
./Workflow/plant2human_v3_stringent.cwl \
./job/plant2human_v3_stringent_example_zm100.yml
```
---

&nbsp;

## Structural Alignment vs Sequence Alignment (global alignment)

![image](../../image/zm_100_stringent_needle_filter.png)

&nbsp;

## Structural Alignment vs Sequence Alignment (local alignment)

![image](../../image/zm_100_stringent_water_filter.png)

&nbsp;

## 📚 Related Files

- **YAML parameter file:** [`../../job/plant2human_v3_stringent_example_at100.yml`](../../job/plant2human_v3_stringent_example_at100.yml)
- **Main README:** [`../../README.md`](../../README.md)
- **Workflow:** [`../../Workflow/plant2human_v3_stringent.cwl`](../../Workflow/plant2human_v3_stringent.cwl)

---