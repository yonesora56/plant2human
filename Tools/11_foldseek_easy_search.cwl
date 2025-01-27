#!/usr/bin/env cwl-runner
# Generated from: foldseek easy-search ../Data/rice_up_mmCIFfile/*.cif ../index/index_uniprot/uniprot ../out/foldseek_output_uniprot_up_all_evalue01.tsv ../tmp -e 0.1 --format-mode 4 --format-output query,target,evalue,prob,gapopen,pident,fident,nident,qstart,qend,qlen,tstart,tend,tlen,alnlen,qcov,tcov,lddt,qtmscore,ttmscore,alntmscore,rmsd,taxid,taxname,taxlineage,qaln,taln,mismatch,lddtfull --threads 10 --split-memory-limit 60G
class: CommandLineTool
cwlVersion: v1.2
label: "foldseek easy-search (3Di+AA mode)"
doc: "Foldseek easy-search command process. Performs structural similarity search of structure files (e.g., CIF format) obtained from 01_uniprot_id_mapping.cwl against the index."


baseCommand: [foldseek, easy-search]
arguments:
  - $(inputs.files)
  - $(inputs.index)
  - $(inputs.output_file_name)
  - $(runtime.tmpdir)
  - -e
  - $(inputs.e_value)
  - --alignment-type
  - $(inputs.alignment_type)
  - --format-mode
  - $(inputs.format_mode)
  - --format-output
  - $(inputs.format_output)
  - --threads
  - $(inputs.threads)
  - --split-memory-limit
  - $(inputs.split_memory_limit)
  - --input-format
  - $(inputs.input_file_format)
  - --taxon-list
  - $(inputs.taxonomy_id_list)
inputs:
  - id: files
    label: "protein structure files"
    doc: "protein structure files. e.g. ../Data/rice_up_mmCIFfile/*.cif"
    type: File[]
  
  - id: index
    label: "Foldseek index file"
    doc: |
      Foldseek index file for searching
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
  
  - id: output_file_name
    label: "Output file name"
    format: edam:data_1050
    doc: |
      Output file name for search results name (tsv format)
    type: string
    default: "foldseek_output_swissprot_up_all_evalue01.tsv"

  - id: e_value
    label: "E-value"
    doc: |
      E-value threshold for search results
    type: double
    default: 0.1

  - id: alignment_type
    label: "Alignment type (3Di+AA mode)"
    doc: |
      see `foldseek easy-search --help`
      How to compute the alignment:
      0: 3di alignment
      1: TM alignment
      2: 3Di+AA
    type: int
    default: 2

  - id: format_mode
    label: "Format mode"
    doc: |
      see foldseek easy-search --help
      Output format list:
      0: BLAST-TAB
      1: SAM
      2: BLAST-TAB + query/db length
      3: Pretty HTML
      4: BLAST-TAB + column headers
      5: Calpha only PDB super-posed to query
      BLAST-TAB (0) and BLAST-TAB + column headers (4)support custom output formats (--format-output)
      (5) Superposed PDB files (Calpha only) [0]
    type: int
    default: 4

  - id: format_output
    label: "Format output"
    type: string
    default: "query,target,evalue,prob,gapopen,pident,fident,nident,qstart,qend,qlen,tstart,tend,tlen,alnlen,qcov,tcov,lddt,qtmscore,ttmscore,alntmscore,rmsd,taxid,taxname,taxlineage,qaln,taln,mismatch,lddtfull"
  - id: threads
    label: "Threads"
    type: int
    default: 16

  - id: split_memory_limit
    label: "Split memory limit"
    type: string
    default: 120G
  
  - id: input_file_format
    label: "Input file format"
    doc: |
      Format of input structures:
      0: Auto-detect by extension
      1: PDB
      2: mmCIF
      3: mmJSON
      4: ChemComp
      5: Foldcomp [0]
    
    type: int
    default: 2

  - id: taxonomy_id_list
    label: "Taxonomy ID list"
    doc: |
      Taxonomy ID list for filtering search results
      e.g. "9606,10090,3702,4577,4529"
    type: string
    default: "9606,10090,3702,4577,4529"

outputs:
  - id: all
    label: "Output file"
    doc: |
      Output file for search results (tsv format)
    type: File
    format: edam:format_3475
    outputBinding:
      glob: "$(inputs.output_file_name)"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldseek:9.427df8a--pl5321h5021889_2

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/