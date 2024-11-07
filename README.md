# foldseek process

```bash
export PATH=/workspaces/004_foldseek/foldseek/bin:$PATH
```

&nbsp;

## 0. UniProt ID mapping

- HN-scoreを元にTop1% およびBottom1%の遺伝子を抽出した遺伝子リストをUniProt ID mapping serviceにかける
- この理由としては､EnsemblのBiomartでは取得しづらい情報も取得できるからである

### 2023/02/07

- 改めて､Top1%の遺伝子に対し､ID mappingを行った
- mappingされなかった遺伝子は以下の通りである
- これらの遺伝子は､non-coding とかではなく､ protein-codingではあるものの､Ensemblとのcross-referenceがないものである

&nbsp;

#### upregulated genes

```txt
Os05g0156500
Os01g0699400
Os03g0293000
Os10g0440500
Os05g0156401
```

#### downregulated genes

```txt
Os09g0249750
Os07g0142100
Os12g0116800
Os10g0556000
Os01g0192900
Os04g0578600
```

- TreeFam, PhylomeDB, KO, GeneTreeには情報がなかったので､今回はカラムを削除した
- 以下のようにTSVファイルを取得した

```tsv
From	Entry	Reviewed	Entry Name	Gene Names	AlphaFoldDB	OrthoDB	OMA	eggNOG	InParanoid	HOGENOM
Os04g0107900	A0A0P0W5Z1	unreviewed	A0A0P0W5Z1_ORYSJ	Os04g0107900 OSNPB_040107900	A0A0P0W5Z1;					
Os04g0107900	A0A0P0W604	unreviewed	A0A0P0W604_ORYSJ	Os04g0107900 OSNPB_040107900	A0A0P0W604;		KELHINP;	KOG0019;	A0A0P0W604;	
Os04g0107900	A0A0P0W643	unreviewed	A0A0P0W643_ORYSJ	Os04g0107900 OSNPB_040107900	A0A0P0W643;			
```

&nbsp;

## 1. Gene classification

- OrthoDBと紐づいているか確認
- Ensemblの｢pan-homology｣の情報と紐づいているか確認
- どちらにもヒットしなかった遺伝子､の3つの遺伝子群に分類

&nbsp;

&nbsp;

&nbsp;

## 2. retrieve DB data

### human reference proteome

- AlphaFoldDBからデータセットを取得

### PDB (only human)

- Ensemblから遺伝子に対応するPDB IDを取得
- そのリストを元に､PDBのHTTPサイトからaric2で並列にCIFファイルを取得

&nbsp;

## 3. retrieve rice data from AlphaFoldDB

- 上記のTSVファイルからAlphaFoldDBのIDを取得しWeb APIを用いて､JSONファイルを取得
- そこからCIFファイルのURLを抽出しファイルを取得

&nbsp;

## 4. search by foldseek

- [foldseekのスクリプト](./script/030_foldseek.sh)を用いて､構造類似性検索を行う

&nbsp;

&nbsp;

&nbsp;

## Install Codon as a jupyter kernel

- cmakeが最新のバージョンではなかったので､最新のバージョンをインストール
- <https://github.com/Kitware/CMake/releases> から最新のバージョンをダウンロード
- <https://docs.exaloop.io/codon/advanced/build>
- <https://docs.exaloop.io/codon/interoperability/jupyter>