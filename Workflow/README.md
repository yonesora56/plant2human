# Workflow Definition Files

This directory contains CWL `Workflow` definition files for the plant2human pipeline.

&nbsp;

## 📁 File Structure

| File | Description |
|------|-------------|
| `plant2human_v3_stringent.cwl` | Main workflow (Stringent Mode) - **Recommended** |
| `plant2human_v3_permissive.cwl` | Main workflow (Permissive Mode) |
| `10_foldseek_easy_search_swf_stringent.cwl` | Foldseek sub-workflow (Stringent) |
| `10_foldseek_easy_search_swf_permissive.cwl` | Foldseek sub-workflow (Permissive) |
| `11_retrieve_sequence_swf.cwl` | Sequence retrieval sub-workflow (Common) |

**📝 Note:** Files with `_swf_` in their filenames indicate sub-workflows.

&nbsp;

---

&nbsp;

## Permissive Mode Workflow

This page describes how to use the **Permissive Mode** workflow (`plant2human_v3_permissive.cwl`).

For **Stringent Mode** (recommended), please refer to the [main README](../README.md#3-execution-of-the-plant2human-workflow-main-workflow).

&nbsp;

### Permissive vs Stringent: Key Differences

| Feature | Permissive Mode | Stringent Mode |
|---------|-----------------|----------------|
| Foldseek Index | Pre-built (`foldseek databases`) | Self-built (`foldseek createdb`) |
| Database Options | Swiss-Prot, UniProt50, Proteome, etc. | Human Proteome only |
| AFDB Version | v4 (index) vs v6 (query) | v6 = v6 (consistent) |
| Taxonomy Filtering | ✅ `--taxon-list` available | ❌ Not available |
| Use Case | Exploratory analysis | Rigorous analysis, publications |

&nbsp;

### ⚠️ Important: Version Mismatch Warning

In Permissive Mode, there is a **version mismatch** between:
- **Query structures** (your plant proteins): AFDB **v6**
- **Foldseek pre-built index**: AFDB **v4**

This may result in:
- Minor differences in structure coordinates
- Some proteins having updated structures in v6

For publication-ready analysis, consider using **Stringent Mode**.

&nbsp;

---

&nbsp;

## 📋 YAML Parameter File Reference (Permissive Mode)

**Example file:** [`../job/plant2human_v3_permissive_example_os100.yml`](../job/plant2human_v3_permissive_example_os100.yml)

&nbsp;

### Input File Parameters

| Parameter | Type | Description | Example |
|-----------|------|-------------|---------|
| `INPUT_DIRECTORY` | Directory | Directory containing mmCIF structure files | `../test/.../os_100_genes_mmcif/` |
| `FILE_MATCH_PATTERN` | string | File pattern for structure files | `"*.cif"` |
| `FOLDSEEK_INDEX` | File | Foldseek pre-built index | `../index/index_swiss_prot/swissprot` |
| `QUERY_IDMAPPING_TSV` | File | ID mapping TSV from Step 1 | `..._idmapping_all.tsv` |
| `QUERY_GENE_LIST_TSV` | File | Original gene list TSV | `oryza_sativa_random_100genes_list.tsv` |

&nbsp;

### Foldseek Parameters (Permissive-specific)

| Parameter | Default | Description |
|-----------|---------|-------------|
| `EVALUE` | `0.1` | E-value threshold for structural similarity search |
| `ALIGNMENT_TYPE` | `2` | 0: 3Di only, 1: TM alignment, **2: 3Di+AA (recommended)** |
| `THREADS` | `16` | Number of CPU threads |
| `SPLIT_MEMORY_LIMIT` | `"120G"` | Memory limit for large searches |
| `TAXONOMY_ID_LIST` | `"9606,10090,..."` | **Permissive only:** Filter results by taxonomy IDs |

**📝 Note:** `TAXONOMY_ID_LIST` is only available in Permissive Mode because pre-built indexes include taxonomy information.

&nbsp;

### Taxonomy ID Reference

| Species | Taxonomy ID |
|---------|-------------|
| *Homo sapiens* (Human) | `9606` |
| *Mus musculus* (Mouse) | `10090` |
| *Arabidopsis thaliana* | `3702` |
| *Zea mays* (Maize) | `4577` |
| *Oryza rufipogon* (Wild rice) | `4529` |

&nbsp;

---

&nbsp;

## YAML Template for Permissive Mode

Copy and modify this template for your analysis:

```YAML
# ============================================================
# YAML Parameter File for plant2human_v3_permissive.cwl
# Species: [Your Species Name]
# ============================================================

# ---------- INPUT DIRECTORY ----------
INPUT_DIRECTORY:
  class: Directory
  location: ./path/to/your_mmcif_directory/           # <-- CHANGE THIS!

FILE_MATCH_PATTERN: "*.cif"

# ---------- FOLDSEEK INDEX (Permissive Mode) ----------
# Pre-built index from "foldseek databases" command
FOLDSEEK_INDEX:
  class: File
  location: ../index/index_swiss_prot/swissprot       # <-- Adjust path if needed
  secondaryFiles:
    - class: File
      location: ../index/index_swiss_prot/swissprot_ca
    - class: File
      location: ../index/index_swiss_prot/swissprot_ca.dbtype
    - class: File
      location: ../index/index_swiss_prot/swissprot_ca.index
    - class: File
      location: ../index/index_swiss_prot/swissprot_h
    - class: File
      location: ../index/index_swiss_prot/swissprot_h.dbtype
    - class: File
      location: ../index/index_swiss_prot/swissprot_h.index
    - class: File
      location: ../index/index_swiss_prot/swissprot_mapping
    - class: File
      location: ../index/index_swiss_prot/swissprot_ss
    - class: File
      location: ../index/index_swiss_prot/swissprot_ss.dbtype
    - class: File
      location: ../index/index_swiss_prot/swissprot_ss.index
    - class: File
      location: ../index/index_swiss_prot/swissprot_taxonomy
    - class: File
      location: ../index/index_swiss_prot/swissprot.dbtype
    - class: File
      location: ../index/index_swiss_prot/swissprot.index
    - class: File
      location: ../index/index_swiss_prot/swissprot.lookup
    - class: File
      location: ../index/index_swiss_prot/swissprot.version

# ---------- FOLDSEEK PARAMETERS ----------
OUTPUT_FILE_NAME1: "foldseek_output_[species]_permissive.tsv"   # <-- CHANGE THIS!
EVALUE: 0.1
ALIGNMENT_TYPE: 2
THREADS: 16
SPLIT_MEMORY_LIMIT: "120G"
TAXONOMY_ID_LIST: "9606,10090,3702,4577,4529"                   # <-- Customize if needed

# ---------- EXTRACT TARGET SPECIES ----------
OUTPUT_FILE_NAME2: "foldseek_[species]_9606_permissive.tsv"     # <-- CHANGE THIS!

# ---------- EXTRACT ID COLUMNS ----------
WF_COLUMN_NUMBER_QUERY_SPECIES: 1
OUTPUT_FILE_NAME_QUERY_SPECIES: "foldseek_result_query_species_permissive.txt"
WF_COLUMN_NUMBER_HIT_SPECIES: 2
OUTPUT_FILE_NAME_HIT_SPECIES: "foldseek_result_hit_species_permissive.txt"

# ---------- TOGOID CONVERT ----------
ROUTE_DATASET: "uniprot,ensembl_protein,ensembl_transcript,ensembl_gene,hgnc,hgnc_symbol"
OUTPUT_FILE_NAME3: "foldseek_hit_species_togoid_convert_permissive.tsv"

# ---------- PAPERMILL (Report Notebook) ----------
OUT_NOTEBOOK_NAME: "[species]_plant2human_report_permissive.ipynb"  # <-- CHANGE THIS!

QUERY_IDMAPPING_TSV:
  class: File
  format: edam:format_3475
  location: ./path/to/your_idmapping_all.tsv          # <-- CHANGE THIS!

QUERY_GENE_LIST_TSV:
  class: File
  format: edam:format_3475
  location: ./path/to/your_gene_list.tsv              # <-- CHANGE THIS!&nbsp;
```
---

&nbsp;

## Command Execution Example (Permissive Mode)

```bash
# test date: 2025-12-12
cwltool --debug --outdir ./test/oryza_sativa_test_100genes_202512/plant2human_v3_permissive_result/ \
./Workflow/plant2human_v3_permissive.cwl \
./job/plant2human_v3_permissive_example_os100.yml
```

---

&nbsp;

&nbsp;

## Available Pre-built Indexes 

When using Permissive Mode, you can choose from these pre-built indexes:

| Database | Description | Size |
|----------|-------------|------|
| `Alphafold/Swiss-Prot` | High-quality reviewed proteins | Small |
| `Alphafold/UniProt50` | Clustered at 50% identity | Medium |
| `Alphafold/Proteome` | Reference proteomes | Large |
| `Alphafold/UniProt` | Full UniProt | Very Large |

Use the `foldseek databases --help` command to see all available options. 