# index directory

- This directory is where you place the indexes used by foldseek (`foldseek databases` and `foldseek createdb` command) and the indexes used by BLAST (`blastdbcmd` command).

&nbsp;

## Component files

```bash
.
├── README.md
├── UP000005640_9606_HUMAN_v6.tar
├── afdb_all_sequences_v6.fasta.gz
├── foldseek_createdb.log
├── foldseek_database.log
├── index_human_proteome_v6
│   ├── human_proteome_v6
│   ├── human_proteome_v6.dbtype
│   ├── human_proteome_v6.index
│   ├── human_proteome_v6.lookup
│   ├── human_proteome_v6.source
│   ├── human_proteome_v6_ca
│   ├── human_proteome_v6_ca.dbtype
│   ├── human_proteome_v6_ca.index
│   ├── human_proteome_v6_h
│   ├── human_proteome_v6_h.dbtype
│   ├── human_proteome_v6_h.index
│   ├── human_proteome_v6_mapping
│   ├── human_proteome_v6_ss
│   ├── human_proteome_v6_ss.dbtype
│   └── human_proteome_v6_ss.index
├── index_swiss_prot
│   ├── swissprot
│   ├── swissprot.dbtype
│   ├── swissprot.index
│   ├── swissprot.lookup
│   ├── swissprot.version
│   ├── swissprot_ca
│   ├── swissprot_ca.dbtype
│   ├── swissprot_ca.index
│   ├── swissprot_h
│   ├── swissprot_h.dbtype
│   ├── swissprot_h.index
│   ├── swissprot_mapping
│   ├── swissprot_ss
│   ├── swissprot_ss.dbtype
│   ├── swissprot_ss.index
│   └── swissprot_taxonomy
└── index_uniprot_afdb_all_sequences_v6
    ├── afdb_all_sequences_v6.fasta
    ├── afdb_all_sequences_v6.fasta.00.phd
    ├── afdb_all_sequences_v6.fasta.00.phi
    ├── afdb_all_sequences_v6.fasta.00.phr
    ├── afdb_all_sequences_v6.fasta.00.pin
    ├── afdb_all_sequences_v6.fasta.00.pog
    ├── afdb_all_sequences_v6.fasta.00.psq
    ├── afdb_all_sequences_v6.fasta.01.phd
    ├── afdb_all_sequences_v6.fasta.01.phi
    ├── afdb_all_sequences_v6.fasta.01.phr
    ├── afdb_all_sequences_v6.fasta.01.pin
    ├── afdb_all_sequences_v6.fasta.01.pog
    ├── afdb_all_sequences_v6.fasta.01.psq
    ├── afdb_all_sequences_v6.fasta.02.phd
    ├── afdb_all_sequences_v6.fasta.02.phi
    ├── afdb_all_sequences_v6.fasta.02.phr
    ├── afdb_all_sequences_v6.fasta.02.pin
    ├── afdb_all_sequences_v6.fasta.02.pog
    ├── afdb_all_sequences_v6.fasta.02.psq
    ├── afdb_all_sequences_v6.fasta.03.phd
    ├── afdb_all_sequences_v6.fasta.03.phi
    ├── afdb_all_sequences_v6.fasta.03.phr
    ├── afdb_all_sequences_v6.fasta.03.pin
    ├── afdb_all_sequences_v6.fasta.03.pog
    ├── afdb_all_sequences_v6.fasta.03.psq
    ├── afdb_all_sequences_v6.fasta.04.phd
    ├── afdb_all_sequences_v6.fasta.04.phi
    ├── afdb_all_sequences_v6.fasta.04.phr
    ├── afdb_all_sequences_v6.fasta.04.pin
    ├── afdb_all_sequences_v6.fasta.04.pog
    ├── afdb_all_sequences_v6.fasta.04.psq
    ├── afdb_all_sequences_v6.fasta.05.phd
    ├── afdb_all_sequences_v6.fasta.05.phi
    ├── afdb_all_sequences_v6.fasta.05.phr
    ├── afdb_all_sequences_v6.fasta.05.pin
    ├── afdb_all_sequences_v6.fasta.05.pog
    ├── afdb_all_sequences_v6.fasta.05.psq
    ├── afdb_all_sequences_v6.fasta.06.phd
    ├── afdb_all_sequences_v6.fasta.06.phi
    ├── afdb_all_sequences_v6.fasta.06.phr
    ├── afdb_all_sequences_v6.fasta.06.pin
    ├── afdb_all_sequences_v6.fasta.06.pog
    ├── afdb_all_sequences_v6.fasta.06.psq
    ├── afdb_all_sequences_v6.fasta.07.phd
    ├── afdb_all_sequences_v6.fasta.07.phi
    ├── afdb_all_sequences_v6.fasta.07.phr
    ├── afdb_all_sequences_v6.fasta.07.pin
    ├── afdb_all_sequences_v6.fasta.07.pog
    ├── afdb_all_sequences_v6.fasta.07.psq
    ├── afdb_all_sequences_v6.fasta.08.phd
    ├── afdb_all_sequences_v6.fasta.08.phi
    ├── afdb_all_sequences_v6.fasta.08.phr
    ├── afdb_all_sequences_v6.fasta.08.pin
    ├── afdb_all_sequences_v6.fasta.08.pog
    ├── afdb_all_sequences_v6.fasta.08.psq
    ├── afdb_all_sequences_v6.fasta.09.phd
    ├── afdb_all_sequences_v6.fasta.09.phi
    ├── afdb_all_sequences_v6.fasta.09.phr
    ├── afdb_all_sequences_v6.fasta.09.pin
    ├── afdb_all_sequences_v6.fasta.09.pog
    ├── afdb_all_sequences_v6.fasta.09.psq
    ├── afdb_all_sequences_v6.fasta.10.phd
    ├── afdb_all_sequences_v6.fasta.10.phi
    ├── afdb_all_sequences_v6.fasta.10.phr
    ├── afdb_all_sequences_v6.fasta.10.pin
    ├── afdb_all_sequences_v6.fasta.10.pog
    ├── afdb_all_sequences_v6.fasta.10.psq
    ├── afdb_all_sequences_v6.fasta.11.phd
    ├── afdb_all_sequences_v6.fasta.11.phi
    ├── afdb_all_sequences_v6.fasta.11.phr
    ├── afdb_all_sequences_v6.fasta.11.pin
    ├── afdb_all_sequences_v6.fasta.11.pog
    ├── afdb_all_sequences_v6.fasta.11.psq
    ├── afdb_all_sequences_v6.fasta.12.phd
    ├── afdb_all_sequences_v6.fasta.12.phi
    ├── afdb_all_sequences_v6.fasta.12.phr
    ├── afdb_all_sequences_v6.fasta.12.pin
    ├── afdb_all_sequences_v6.fasta.12.pog
    ├── afdb_all_sequences_v6.fasta.12.psq
    ├── afdb_all_sequences_v6.fasta.13.phd
    ├── afdb_all_sequences_v6.fasta.13.phi
    ├── afdb_all_sequences_v6.fasta.13.phr
    ├── afdb_all_sequences_v6.fasta.13.pin
    ├── afdb_all_sequences_v6.fasta.13.pog
    ├── afdb_all_sequences_v6.fasta.13.psq
    ├── afdb_all_sequences_v6.fasta.14.phd
    ├── afdb_all_sequences_v6.fasta.14.phi
    ├── afdb_all_sequences_v6.fasta.14.phr
    ├── afdb_all_sequences_v6.fasta.14.pin
    ├── afdb_all_sequences_v6.fasta.14.pog
    ├── afdb_all_sequences_v6.fasta.14.psq
    ├── afdb_all_sequences_v6.fasta.15.phd
    ├── afdb_all_sequences_v6.fasta.15.phi
    ├── afdb_all_sequences_v6.fasta.15.phr
    ├── afdb_all_sequences_v6.fasta.15.pin
    ├── afdb_all_sequences_v6.fasta.15.pog
    ├── afdb_all_sequences_v6.fasta.15.psq
    ├── afdb_all_sequences_v6.fasta.16.phd
    ├── afdb_all_sequences_v6.fasta.16.phi
    ├── afdb_all_sequences_v6.fasta.16.phr
    ├── afdb_all_sequences_v6.fasta.16.pin
    ├── afdb_all_sequences_v6.fasta.16.pog
    ├── afdb_all_sequences_v6.fasta.16.psq
    ├── afdb_all_sequences_v6.fasta.17.phd
    ├── afdb_all_sequences_v6.fasta.17.phi
    ├── afdb_all_sequences_v6.fasta.17.phr
    ├── afdb_all_sequences_v6.fasta.17.pin
    ├── afdb_all_sequences_v6.fasta.17.pog
    ├── afdb_all_sequences_v6.fasta.17.psq
    ├── afdb_all_sequences_v6.fasta.18.phd
    ├── afdb_all_sequences_v6.fasta.18.phi
    ├── afdb_all_sequences_v6.fasta.18.phr
    ├── afdb_all_sequences_v6.fasta.18.pin
    ├── afdb_all_sequences_v6.fasta.18.pog
    ├── afdb_all_sequences_v6.fasta.18.psq
    ├── afdb_all_sequences_v6.fasta.19.phd
    ├── afdb_all_sequences_v6.fasta.19.phi
    ├── afdb_all_sequences_v6.fasta.19.phr
    ├── afdb_all_sequences_v6.fasta.19.pin
    ├── afdb_all_sequences_v6.fasta.19.pog
    ├── afdb_all_sequences_v6.fasta.19.psq
    ├── afdb_all_sequences_v6.fasta.20.phd
    ├── afdb_all_sequences_v6.fasta.20.phi
    ├── afdb_all_sequences_v6.fasta.20.phr
    ├── afdb_all_sequences_v6.fasta.20.pin
    ├── afdb_all_sequences_v6.fasta.20.pog
    ├── afdb_all_sequences_v6.fasta.20.psq
    ├── afdb_all_sequences_v6.fasta.21.phd
    ├── afdb_all_sequences_v6.fasta.21.phi
    ├── afdb_all_sequences_v6.fasta.21.phr
    ├── afdb_all_sequences_v6.fasta.21.pin
    ├── afdb_all_sequences_v6.fasta.21.pog
    ├── afdb_all_sequences_v6.fasta.21.psq
    ├── afdb_all_sequences_v6.fasta.22.phd
    ├── afdb_all_sequences_v6.fasta.22.phi
    ├── afdb_all_sequences_v6.fasta.22.phr
    ├── afdb_all_sequences_v6.fasta.22.pin
    ├── afdb_all_sequences_v6.fasta.22.pog
    ├── afdb_all_sequences_v6.fasta.22.psq
    ├── afdb_all_sequences_v6.fasta.23.phd
    ├── afdb_all_sequences_v6.fasta.23.phi
    ├── afdb_all_sequences_v6.fasta.23.phr
    ├── afdb_all_sequences_v6.fasta.23.pin
    ├── afdb_all_sequences_v6.fasta.23.pog
    ├── afdb_all_sequences_v6.fasta.23.psq
    ├── afdb_all_sequences_v6.fasta.24.phd
    ├── afdb_all_sequences_v6.fasta.24.phi
    ├── afdb_all_sequences_v6.fasta.24.phr
    ├── afdb_all_sequences_v6.fasta.24.pin
    ├── afdb_all_sequences_v6.fasta.24.pog
    ├── afdb_all_sequences_v6.fasta.24.psq
    ├── afdb_all_sequences_v6.fasta.25.phd
    ├── afdb_all_sequences_v6.fasta.25.phi
    ├── afdb_all_sequences_v6.fasta.25.phr
    ├── afdb_all_sequences_v6.fasta.25.pin
    ├── afdb_all_sequences_v6.fasta.25.pog
    ├── afdb_all_sequences_v6.fasta.25.psq
    ├── afdb_all_sequences_v6.fasta.26.phd
    ├── afdb_all_sequences_v6.fasta.26.phi
    ├── afdb_all_sequences_v6.fasta.26.phr
    ├── afdb_all_sequences_v6.fasta.26.pin
    ├── afdb_all_sequences_v6.fasta.26.pog
    ├── afdb_all_sequences_v6.fasta.26.psq
    ├── afdb_all_sequences_v6.fasta.pal
    ├── afdb_all_sequences_v6.fasta.pdb
    ├── afdb_all_sequences_v6.fasta.pjs
    ├── afdb_all_sequences_v6.fasta.pos
    ├── afdb_all_sequences_v6.fasta.pot
    ├── afdb_all_sequences_v6.fasta.ptf
    └── afdb_all_sequences_v6.fasta.pto

3 directories, 206 files
```