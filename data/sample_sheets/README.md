features.csv
================
Peter Hickey
2023-02-14

**CellRanger** requires a CSV file describing the antibody derived tag
(ADT) and hashtag oligo (HTO) features, which we refer to as
`features.csv`. The `features.csv` file is the concatenation of a
`ADT_features.csv` and a `HTO_features.csv` file.

This document briefly describes how we generated the `features.csv`
file.

## `ADT_features.csv`

We used the [TotalSeq™-A Mouse Universal Cocktail,
V1.0](https://www.biolegend.com/ja-jp/products/totalseq-a-mouse-universal-cocktail-v1-21733)
from BioLegend. All antibodies are anti-mouse unless otherwise
specified. The associated metadata for this panel is available in the
Excel file
[`TotalSeq_A_Mouse_Universal_Cocktail_v1_128_Antibodies_199901_Barcodes.xlsx`](TotalSeq_A_Mouse_Universal_Cocktail_v1_128_Antibodies_199901_Barcodes.xlsx)
(source:
[BioLegend](https://www.biolegend.com/Files/Images/BioLegend/totalseq/TotalSeq_A_Mouse_Universal_Cocktail_v1_128_Antibodies_199901_Barcodes.xlsx)):

``` r
library(here)
```

    ## here() starts at /stornext/Projects/score/Analyses/G000304_Broomfield

``` r
library(readxl)
x <- read_excel(
  here(
    "data", 
    "sample_sheets",
    "TotalSeq_A_Mouse_Universal_Cocktail_v1_128_Antibodies_199901_Barcodes.xlsx"))
knitr::kable(x)
```

| DNA_ID | Description                              | Clone           | Sequence        | Ensemble ID        |
|:-------|:-----------------------------------------|:----------------|:----------------|:-------------------|
| A0001  | anti-mouse CD4                           | RM4-5           | AACAAGACCCTTGAG | ENSMUSG00000023274 |
| A0002  | anti-mouse CD8a                          | 53-6.7          | TACCCGTAATAGCGT | ENSMUSG00000053977 |
| A0003  | anti-mouse CD366 (Tim-3)                 | RMT3-23         | ATTGGCACTCAGATG | ENSMUSG00000020399 |
| A0004  | anti-mouse CD279 (PD-1)                  | RMP1-30         | GAAAGTCAAAGCACT | ENSMUSG00000026285 |
| A0013  | anti-mouse Ly-6C                         | HK1.4           | AAGTCGTGAGGCATG | ENSMUSG00000022584 |
| A0014  | anti-mouse/human CD11b                   | M1/70           | TGAAGGCTCATTTGT | ENSMUSG00000030786 |
| A0015  | anti-mouse Ly-6G                         | 1A8             | ACATTGACGCAACTA | ENSMUSG00000022582 |
| A0070  | anti-human/mouse CD49f                   | GoH3            | TTCCGAGGATGATCT | ENSMUSG00000027111 |
| A0073  | anti-mouse/human CD44                    | IM7             | TGGCTTCAGGTCCTA | ENSMUSG00000005087 |
| A0074  | anti-mouse CD54                          | YN1/1.7.4       | ATAACCGACACAGTG | ENSMUSG00000037405 |
| A0075  | anti-mouse CD90.2                        | 30-H12          | CCGATCAGCCGTTTA | ENSMUSG00000032011 |
| A0077  | anti-mouse CD73                          | TY/11.8         | ACACTTAACGTCTGG | ENSMUSG00000032420 |
| A0078  | anti-mouse CD49d                         | R1-2            | CGCTTGGACGCTTAA | ENSMUSG00000027009 |
| A0079  | anti-mouse CD200 (OX2)                   | OX-90           | TCAATTCCGGTAGTC | ENSMUSG00000022661 |
| A0090  | Mouse IgG1, κ isotype Ctrl               | MOPC-21         | GCCGGACGACATTAA | NA                 |
| A0091  | Mouse IgG2a, κ isotype Ctrl              | MOPC-173        | CTCCTACCTAAACTG | NA                 |
| A0092  | Mouse IgG2b, κ isotype Ctrl              | MPC-11          | ATATGTATCACGCGA | NA                 |
| A0093  | anti-mouse CD19                          | 6D5             | ATCAGCCATGTCAGT | ENSMUSG00000030724 |
| A0095  | Rat IgG2b, κ Isotype Ctrl                | RTK4530         | GATTCTTGACGACCT | NA                 |
| A0096  | anti-mouse CD45                          | 30-F11          | TGGCTATGGAGCAGA | ENSMUSG00000026395 |
| A0097  | anti-mouse CD25                          | PC61            | ACCATGAGACACAGT | ENSMUSG00000026770 |
| A0103  | anti-mouse/human CD45R/B220              | RA3-6B2         | CCTACACCTCATAAT | ENSMUSG00000026395 |
| A0104  | anti-mouse CD102                         | 3C4 (MIC2/4)    | GATATTCAGTGCGAC | ENSMUSG00000001029 |
| A0105  | anti-mouse CD115 (CSF-1R)                | AFS98           | TTCCGTTGTTGTGAG | ENSMUSG00000024621 |
| A0106  | anti-mouse CD11c                         | N418            | GTTATGGACGCTTGC | ENSMUSG00000030789 |
| A0107  | anti-mouse CD21/CD35 (CR2/CR1)           | 7 E9            | GGATAATTTCGATCC | ENSMUSG00000026616 |
| A0108  | anti-mouse CD23                          | B3B4            | TCTCTTGGAAGATGA | ENSMUSG00000005540 |
| A0110  | anti-mouse CD43                          | S11             | TTGGAGGGTTGTGCT | ENSMUSG00000051457 |
| A0111  | anti-mouse CD5                           | 53-7.3          | CAGCTCAGTGTGTTG | ENSMUSG00000024669 |
| A0112  | anti-mouse CD62L                         | MEL-14          | TGGGCCTAAGTCATC | ENSMUSG00000026581 |
| A0113  | anti-mouse CD93 (AA4.1, early B lineage) | AA4.1           | GGTATTTCCTGTGGT | ENSMUSG00000027435 |
| A0114  | anti-mouse F4/80                         | BM8             | TTAACTTCAGCCCGT | ENSMUSG00000004730 |
| A0115  | anti-mouse FcεRIα                        | MAR-1           | AGTCACCTCGAAGCT | ENSMUSG00000005339 |
| A0117  | anti-mouse I-A/I-E                       | M5/114.15.2     | GGTCACCAGTATGAT | ENSMUSG00000073421 |
| A0118  | anti-mouse NK-1.1                        | PK136           | GTAACATTACTCGTC | ENSMUSG00000030325 |
| A0119  | anti-mouse Siglec H                      | 551             | CCGCACCTACATTAG | ENSMUSG00000051504 |
| A0120  | anti-mouse TCR β chain                   | H57-597         | TCCTATGGGACTCAG | NA                 |
| A0121  | anti-mouse TCR γ/δ                       | GL3             | AACCCAAATAGCTGA | NA                 |
| A0122  | anti-mouse TER-119/Erythroid Cells       | TER-119         | GCGCGTTTGTGCTAT | NA                 |
| A0130  | anti-mouse Ly-6A/E (Sca-1)               | D7              | TTCCTTTCCTACGCA | ENSMUSG00000075602 |
| A0157  | anti-mouse CD45.2                        | 104             | CACCGTCATTCAACC | ENSMUSG00000026395 |
| A0182  | anti-mouse CD3                           | 17A2            | GTATGTCCGCTCGAT | ENSMUSG00000002033 |
| A0190  | anti-mouse CD274 (B7-H1, PD-L1)          | MIH6            | TCGATTCCACCAACT | ENSMUSG00000016496 |
| A0191  | anti-mouse/rat/human CD27                | LG.3A10         | CAAGGTATGTCACTG | ENSMUSG00000030336 |
| A0192  | anti-mouse CD20                          | SA275A11        | TCCACTCCCTGTATA | ENSMUSG00000024673 |
| A0193  | anti-mouse CD357 (GITR)                  | DTA-1           | GGCACTCTGTAACAT | ENSMUSG00000041954 |
| A0194  | anti-mouse CD137                         | 17B5            | TCCCTGTATAGATGA | ENSMUSG00000028965 |
| A0195  | anti-mouse CD134 (OX-40)                 | OX-86           | CTCACCTACCTATGG | ENSMUSG00000029075 |
| A0197  | anti-mouse CD69                          | H1.2F3          | TTGTATTCCGCCATT | ENSMUSG00000030156 |
| A0198  | anti-mouse CD127 (IL-7Rα)                | A7R34           | GTGTGAGGCACTCTT | ENSMUSG00000003882 |
| A0200  | anti-mouse CD86                          | GL-1            | CTGGATTTGTGTATC | ENSMUSG00000022901 |
| A0201  | anti-mouse CD103                         | 2 E7            | TTCATTAGCCCGCTG | ENSMUSG00000005947 |
| A0202  | anti-mouse CD64 (FcγRI)                  | X54-5/7.1       | AGCAATTAACGGGAG | ENSMUSG00000015947 |
| A0203  | anti-mouse CD150 (SLAM)                  | TC15-12F12.2    | CAACGCCTAGAAACC | ENSMUSG00000015316 |
| A0212  | anti-mouse CD24                          | M1/69           | TATATCTTTGCCGCA | ENSMUSG00000047139 |
| A0214  | anti-human/mouse integrin β7             | FIB504          | TCCTTGGATGTACCG | ENSMUSG00000001281 |
| A0226  | anti-mouse CD106                         | 429 (MVCAM.A)   | CGTTCCTACCTACCT | ENSMUSG00000027962 |
| A0230  | anti-mouse CD8b (Ly-3)                   | YTS156.7.7      | TTCCCTCTATGGAGC | ENSMUSG00000053044 |
| A0236  | Rat IgG1, κ isotype Ctrl                 | RTK2071         | ATCAGATGCCCTCAT | NA                 |
| A0237  | Rat IgG1, λ Isotype Ctrl                 | G0114F7         | GGGAGCGATTCAACT | NA                 |
| A0238  | Rat IgG2a, κ Isotype Ctrl                | RTK2758         | AAGTCAGGTTCGTTT | NA                 |
| A0240  | Rat IgG2c, κ Isotype Ctrl                | RTK4174         | TCCAGGCTAGTCATT | NA                 |
| A0241  | Armenian Hamster IgG Isotype Ctrl        | HTK888          | CCTGTCATTAAGACT | NA                 |
| A0250  | anti-mouse/human KLRG1 (MAFA)            | 2F1/KLRG1       | GTAGTAGGCTAGACC | ENSMUSG00000030114 |
| A0378  | anti-mouse CD223 (LAG-3)                 | C9B7W           | ATTCCGTCCCTAAGG | ENSMUSG00000030124 |
| A0417  | anti-mouse CD163                         | S15049I         | GAGCAAGATTAAGAC | ENSMUSG00000008845 |
| A0421  | anti-mouse CD49b                         | HMα2            | CGCGTTAGTAGAGTC | ENSMUSG00000015533 |
| A0422  | anti-mouse CD172a (SIRPα)                | P84             | GATTCCCTTGTAGCA | ENSMUSG00000037902 |
| A0429  | anti-mouse CD48                          | HM48-1          | AGAACCGCCGTAGTT | ENSMUSG00000015355 |
| A0431  | anti-mouse CD170 (Siglec-F)              | S17007L         | TCAATCTCCGTCGCT | ENSMUSG00000039013 |
| A0440  | anti-mouse CD169/Siglec-1                | 3D6.112         | ATTGACGACAGTCAT | ENSMUSG00000027322 |
| A0441  | anti-mouse CD71                          | RI7217          | ACCGACCAGTAGACA | ENSMUSG00000022797 |
| A0443  | anti-mouse CD41                          | MWReg30         | ACTTGGATGGACACT | ENSMUSG00000034664 |
| A0450  | anti-mouse IgM                           | RMM-1           | AGCTACGCATTCAAT | ENSMUSG00000076617 |
| A0551  | anti-mouse CD301a                        | LOM-8.7         | TGTATTTACTCACCG | ENSMUSG00000000318 |
| A0552  | anti-mouse CD304 (Neuropilin-1)          | 3 E12           | CCAGCTCATTCAACG | ENSMUSG00000025810 |
| A0555  | anti-mouse CD36                          | HM36            | TTTGCCGCTACGACA | ENSMUSG00000002944 |
| A0557  | anti-mouse CD38                          | 90              | CGTATCCGTCTCCTA | ENSMUSG00000029084 |
| A0558  | anti-mouse CD55 (DAF)                    | RIKO-3          | ATTGTTGTCAGACCA | ENSMUSG00000026399 |
| A0559  | anti-mouse CD63                          | NVG-2           | ATCCGACACGTATTA | ENSMUSG00000025351 |
| A0560  | anti-mouse CD68                          | FA-11           | CTTTCTTTCACGGGA | ENSMUSG00000018774 |
| A0561  | anti-mouse CD79b (Igβ)                   | HM79-12         | TAACTCAGTGCGAGT | ENSMUSG00000040592 |
| A0562  | anti-mouse CD83                          | Michel-19       | TCTCAGGCTTCCTAG | ENSMUSG00000015396 |
| A0563  | anti-mouse CX3CR1                        | SA011F11        | CACTCTCAGTCCTAT | ENSMUSG00000052336 |
| A0566  | anti-mouse CD301b                        | URA-1           | CTTGCCTTGCGATTT | ENSMUSG00000040950 |
| A0567  | anti-mouse Tim-4                         | RMT4-54         | TGCTGGAGGGTATTC | ENSMUSG00000055546 |
| A0568  | anti-mouse/rat XCR1                      | ZET             | TCCATTACCCACGTT | ENSMUSG00000060509 |
| A0570  | anti-mouse/rat CD29                      | HMβ1-1          | ACGCATTCCTTGTGT | ENSMUSG00000025809 |
| A0571  | anti-mouse IgD                           | 11-26c.2a       | TCATATCCGTTGTCC | ENSMUSG00000104213 |
| A0595  | anti-mouse CD11a                         | M17/4           | AGAGTCTCCCTTTAG | ENSMUSG00000030830 |
| A0807  | anti-mouse CD200R (OX2R)                 | OX-110          | ATTCTTTCCCTCTGT | ENSMUSG00000022667 |
| A0809  | anti-mouse CD200R3                       | Ba13            | ATCAACTTGGAGCAG | ENSMUSG00000036172 |
| A0810  | anti-mouse CD138 (Syndecan-1)            | 281-2           | GCGTTTGTATGTACT | ENSMUSG00000020592 |
| A0811  | anti-mouse CD317 (BST2, PDCA-1)          | 927             | TGTGGTAGCCCTTGT | ENSMUSG00000046718 |
| A0813  | anti-mouse CD9                           | MZ3             | TAGCAGTCACTCCTA | ENSMUSG00000030342 |
| A0825  | anti-mouse CD371 (CLEC12A)               | 5D3/CLEC12A     | GCGAGAAATCTGCAT | ENSMUSG00000053063 |
| A0827  | anti-mouse CD22                          | OX-97           | AGGTCCTCTCTGGAT | ENSMUSG00000030577 |
| A0837  | anti-mouse IL-33Rα (IL1RL1, ST2)         | DIH9            | GCGATGGAGCATGTT | ENSMUSG00000026069 |
| A0839  | anti-mouse Ly49H                         | 3D10            | CCAGTAGGCTTATTA | ENSMUSG00000089727 |
| A0841  | anti-mouse Ly49D                         | 4 E5            | TATATCCCTCAACGC | ENSMUSG00000079852 |
| A0842  | anti-mouse Ly-49A                        | YE1/48.10.6     | AATTCCGTCAGATGA | ENSMUSG00000079853 |
| A0846  | anti-mouse CD185 (CXCR5)                 | L138D7          | ACGTAGTCACCTAGT | ENSMUSG00000047880 |
| A0850  | anti-mouse CD49a                         | HMα1            | CCATTCATTTGTGGC | ENSMUSG00000042284 |
| A0851  | anti-mouse CD1d (CD1.1, Ly-38)           | 1B1             | CAACTTGGCCGAATC | ENSMUSG00000028076 |
| A0852  | anti-mouse CD226 (DNAM-1)                | 10 E5           | ACGCAGTATTTCCGA | ENSMUSG00000034028 |
| A0854  | anti-mouse CD199 (CCR9)                  | CW-1.2          | CCCTCTGGTATGGTT | ENSMUSG00000029530 |
| A0877  | anti-mouse JAML                          | 4 E10           | GTTATGGTTCGTGTT | ENSMUSG00000048534 |
| A0881  | anti-mouse CD272 (BTLA)                  | 6A6             | TGACCCTATTGAGAA | ENSMUSG00000052013 |
| A0882  | anti-mouse PIR-A/B                       | 6C1             | TGTAGAGTCAGACCT | ENSMUSG00000081665 |
| A0883  | anti-mouse CD26 (DPP-4)                  | H194-112        | ATGGCCTGTCATAAT | ENSMUSG00000035000 |
| A0885  | anti-mouse CD270 (HVEM)                  | HMHV-1B18       | GATCCGTGTTGCCTA | ENSMUSG00000042333 |
| A0892  | anti-mouse CD2                           | RM2-5           | TTGCCGTGTGTTTAA | ENSMUSG00000027863 |
| A0893  | anti-mouse CD120b (TNF R Type II/p75)    | TR75-89         | GAAGCTGTATCCGAA | ENSMUSG00000028599 |
| A0903  | anti-mouse CD40                          | 3/23            | ATTTGTATGCTGGAG | ENSMUSG00000017652 |
| A0904  | anti-mouse CD31                          | 390             | GCTGTAGTATCATGT | ENSMUSG00000020717 |
| A0905  | anti-mouse CD107a (LAMP-1)               | 1D4B            | AAATCTGTGCCGTAC | ENSMUSG00000031447 |
| A0910  | anti-mouse/rat CD61                      | 2C9.G2 (HMβ3-1) | TTCTTTACCCGCCTG | ENSMUSG00000020689 |
| A0915  | anti-mouse VISTA (PD-1H)                 | MIH63           | ACATTTCCCTTGCCT | ENSMUSG00000020101 |
| A0926  | anti-mouse CD186 (CXCR6)                 | SA051D1         | TGTCAGGTTGTATTC | ENSMUSG00000048521 |
| A0927  | anti-mouse CD159a (NKG2AB6)              | 16A11           | GTGTTTGTGTTCCTG | ENSMUSG00000030167 |
| A0930  | anti-mouse Ly108                         | 330-AJ          | CGATTCTTTGCGAGT | ENSMUSG00000015314 |
| A1006  | anti-mouse CD160                         | 7H1             | GCGTATGTCAGTACC | ENSMUSG00000038304 |
| A1007  | anti-mouse CD85k (gp49 Receptor)         | H1.1            | ATGTCAACTCTGGGA | ENSMUSG00000112148 |
| A1008  | anti-mouse CD51                          | RMV-7           | GGAGTCAGGGTATTA | ENSMUSG00000027087 |
| A1009  | anti-mouse CD94                          | 18d3            | CACAGTTGTCCGTGT | ENSMUSG00000030165 |
| A1010  | anti-mouse CD205 (DEC-205)               | NLDC-145        | CATATTGGCCGTAGT | ENSMUSG00000026980 |
| A1011  | anti-mouse CD155 (PVR)                   | TX56            | TAGCTTGGGATTAAG | ENSMUSG00000040511 |
| A1064  | anti-mouse/rat CD81                      | Eat-2           | TTGTCACCAACTTCC | ENSMUSG00000037706 |

I have used the information in
`TotalSeq_A_Mouse_Universal_Cocktail_v1_128_Antibodies_199901_Barcodes.xlsx`
to create a [`ADT_features.csv`](ADT_features.csv) file that is
compatible with **CellRanger**.

``` r
y <- data.frame(
  id = x$DNA_ID,
  # NOTE: Tidy up to remove most "anti-mouse" (and variations thereon) prefixes
  #       and replace ",", with ";" to avoid parsing issues of the resultant 
  #       CSV.
  name = gsub(",", ";", gsub("anti-mouse ", "", x$Description)),
  read = rep("R2", nrow(x)),
  pattern = rep("^(BC)", nrow(x)),
  sequence = x$Sequence,
  feature_type = rep("Antibody Capture", nrow(x)))
write.csv(
  y,
  file = here("data", "sample_sheets", "ADT_features.csv"),
  row.names = FALSE,
  quote = TRUE)
knitr::kable(y)
```

| id    | name                              | read | pattern | sequence        | feature_type     |
|:------|:----------------------------------|:-----|:--------|:----------------|:-----------------|
| A0001 | CD4                               | R2   | ^(BC)   | AACAAGACCCTTGAG | Antibody Capture |
| A0002 | CD8a                              | R2   | ^(BC)   | TACCCGTAATAGCGT | Antibody Capture |
| A0003 | CD366 (Tim-3)                     | R2   | ^(BC)   | ATTGGCACTCAGATG | Antibody Capture |
| A0004 | CD279 (PD-1)                      | R2   | ^(BC)   | GAAAGTCAAAGCACT | Antibody Capture |
| A0013 | Ly-6C                             | R2   | ^(BC)   | AAGTCGTGAGGCATG | Antibody Capture |
| A0014 | anti-mouse/human CD11b            | R2   | ^(BC)   | TGAAGGCTCATTTGT | Antibody Capture |
| A0015 | Ly-6G                             | R2   | ^(BC)   | ACATTGACGCAACTA | Antibody Capture |
| A0070 | anti-human/mouse CD49f            | R2   | ^(BC)   | TTCCGAGGATGATCT | Antibody Capture |
| A0073 | anti-mouse/human CD44             | R2   | ^(BC)   | TGGCTTCAGGTCCTA | Antibody Capture |
| A0074 | CD54                              | R2   | ^(BC)   | ATAACCGACACAGTG | Antibody Capture |
| A0075 | CD90.2                            | R2   | ^(BC)   | CCGATCAGCCGTTTA | Antibody Capture |
| A0077 | CD73                              | R2   | ^(BC)   | ACACTTAACGTCTGG | Antibody Capture |
| A0078 | CD49d                             | R2   | ^(BC)   | CGCTTGGACGCTTAA | Antibody Capture |
| A0079 | CD200 (OX2)                       | R2   | ^(BC)   | TCAATTCCGGTAGTC | Antibody Capture |
| A0090 | Mouse IgG1; κ isotype Ctrl        | R2   | ^(BC)   | GCCGGACGACATTAA | Antibody Capture |
| A0091 | Mouse IgG2a; κ isotype Ctrl       | R2   | ^(BC)   | CTCCTACCTAAACTG | Antibody Capture |
| A0092 | Mouse IgG2b; κ isotype Ctrl       | R2   | ^(BC)   | ATATGTATCACGCGA | Antibody Capture |
| A0093 | CD19                              | R2   | ^(BC)   | ATCAGCCATGTCAGT | Antibody Capture |
| A0095 | Rat IgG2b; κ Isotype Ctrl         | R2   | ^(BC)   | GATTCTTGACGACCT | Antibody Capture |
| A0096 | CD45                              | R2   | ^(BC)   | TGGCTATGGAGCAGA | Antibody Capture |
| A0097 | CD25                              | R2   | ^(BC)   | ACCATGAGACACAGT | Antibody Capture |
| A0103 | anti-mouse/human CD45R/B220       | R2   | ^(BC)   | CCTACACCTCATAAT | Antibody Capture |
| A0104 | CD102                             | R2   | ^(BC)   | GATATTCAGTGCGAC | Antibody Capture |
| A0105 | CD115 (CSF-1R)                    | R2   | ^(BC)   | TTCCGTTGTTGTGAG | Antibody Capture |
| A0106 | CD11c                             | R2   | ^(BC)   | GTTATGGACGCTTGC | Antibody Capture |
| A0107 | CD21/CD35 (CR2/CR1)               | R2   | ^(BC)   | GGATAATTTCGATCC | Antibody Capture |
| A0108 | CD23                              | R2   | ^(BC)   | TCTCTTGGAAGATGA | Antibody Capture |
| A0110 | CD43                              | R2   | ^(BC)   | TTGGAGGGTTGTGCT | Antibody Capture |
| A0111 | CD5                               | R2   | ^(BC)   | CAGCTCAGTGTGTTG | Antibody Capture |
| A0112 | CD62L                             | R2   | ^(BC)   | TGGGCCTAAGTCATC | Antibody Capture |
| A0113 | CD93 (AA4.1; early B lineage)     | R2   | ^(BC)   | GGTATTTCCTGTGGT | Antibody Capture |
| A0114 | F4/80                             | R2   | ^(BC)   | TTAACTTCAGCCCGT | Antibody Capture |
| A0115 | FcεRIα                            | R2   | ^(BC)   | AGTCACCTCGAAGCT | Antibody Capture |
| A0117 | I-A/I-E                           | R2   | ^(BC)   | GGTCACCAGTATGAT | Antibody Capture |
| A0118 | NK-1.1                            | R2   | ^(BC)   | GTAACATTACTCGTC | Antibody Capture |
| A0119 | Siglec H                          | R2   | ^(BC)   | CCGCACCTACATTAG | Antibody Capture |
| A0120 | TCR β chain                       | R2   | ^(BC)   | TCCTATGGGACTCAG | Antibody Capture |
| A0121 | TCR γ/δ                           | R2   | ^(BC)   | AACCCAAATAGCTGA | Antibody Capture |
| A0122 | TER-119/Erythroid Cells           | R2   | ^(BC)   | GCGCGTTTGTGCTAT | Antibody Capture |
| A0130 | Ly-6A/E (Sca-1)                   | R2   | ^(BC)   | TTCCTTTCCTACGCA | Antibody Capture |
| A0157 | CD45.2                            | R2   | ^(BC)   | CACCGTCATTCAACC | Antibody Capture |
| A0182 | CD3                               | R2   | ^(BC)   | GTATGTCCGCTCGAT | Antibody Capture |
| A0190 | CD274 (B7-H1; PD-L1)              | R2   | ^(BC)   | TCGATTCCACCAACT | Antibody Capture |
| A0191 | anti-mouse/rat/human CD27         | R2   | ^(BC)   | CAAGGTATGTCACTG | Antibody Capture |
| A0192 | CD20                              | R2   | ^(BC)   | TCCACTCCCTGTATA | Antibody Capture |
| A0193 | CD357 (GITR)                      | R2   | ^(BC)   | GGCACTCTGTAACAT | Antibody Capture |
| A0194 | CD137                             | R2   | ^(BC)   | TCCCTGTATAGATGA | Antibody Capture |
| A0195 | CD134 (OX-40)                     | R2   | ^(BC)   | CTCACCTACCTATGG | Antibody Capture |
| A0197 | CD69                              | R2   | ^(BC)   | TTGTATTCCGCCATT | Antibody Capture |
| A0198 | CD127 (IL-7Rα)                    | R2   | ^(BC)   | GTGTGAGGCACTCTT | Antibody Capture |
| A0200 | CD86                              | R2   | ^(BC)   | CTGGATTTGTGTATC | Antibody Capture |
| A0201 | CD103                             | R2   | ^(BC)   | TTCATTAGCCCGCTG | Antibody Capture |
| A0202 | CD64 (FcγRI)                      | R2   | ^(BC)   | AGCAATTAACGGGAG | Antibody Capture |
| A0203 | CD150 (SLAM)                      | R2   | ^(BC)   | CAACGCCTAGAAACC | Antibody Capture |
| A0212 | CD24                              | R2   | ^(BC)   | TATATCTTTGCCGCA | Antibody Capture |
| A0214 | anti-human/mouse integrin β7      | R2   | ^(BC)   | TCCTTGGATGTACCG | Antibody Capture |
| A0226 | CD106                             | R2   | ^(BC)   | CGTTCCTACCTACCT | Antibody Capture |
| A0230 | CD8b (Ly-3)                       | R2   | ^(BC)   | TTCCCTCTATGGAGC | Antibody Capture |
| A0236 | Rat IgG1; κ isotype Ctrl          | R2   | ^(BC)   | ATCAGATGCCCTCAT | Antibody Capture |
| A0237 | Rat IgG1; λ Isotype Ctrl          | R2   | ^(BC)   | GGGAGCGATTCAACT | Antibody Capture |
| A0238 | Rat IgG2a; κ Isotype Ctrl         | R2   | ^(BC)   | AAGTCAGGTTCGTTT | Antibody Capture |
| A0240 | Rat IgG2c; κ Isotype Ctrl         | R2   | ^(BC)   | TCCAGGCTAGTCATT | Antibody Capture |
| A0241 | Armenian Hamster IgG Isotype Ctrl | R2   | ^(BC)   | CCTGTCATTAAGACT | Antibody Capture |
| A0250 | anti-mouse/human KLRG1 (MAFA)     | R2   | ^(BC)   | GTAGTAGGCTAGACC | Antibody Capture |
| A0378 | CD223 (LAG-3)                     | R2   | ^(BC)   | ATTCCGTCCCTAAGG | Antibody Capture |
| A0417 | CD163                             | R2   | ^(BC)   | GAGCAAGATTAAGAC | Antibody Capture |
| A0421 | CD49b                             | R2   | ^(BC)   | CGCGTTAGTAGAGTC | Antibody Capture |
| A0422 | CD172a (SIRPα)                    | R2   | ^(BC)   | GATTCCCTTGTAGCA | Antibody Capture |
| A0429 | CD48                              | R2   | ^(BC)   | AGAACCGCCGTAGTT | Antibody Capture |
| A0431 | CD170 (Siglec-F)                  | R2   | ^(BC)   | TCAATCTCCGTCGCT | Antibody Capture |
| A0440 | CD169/Siglec-1                    | R2   | ^(BC)   | ATTGACGACAGTCAT | Antibody Capture |
| A0441 | CD71                              | R2   | ^(BC)   | ACCGACCAGTAGACA | Antibody Capture |
| A0443 | CD41                              | R2   | ^(BC)   | ACTTGGATGGACACT | Antibody Capture |
| A0450 | IgM                               | R2   | ^(BC)   | AGCTACGCATTCAAT | Antibody Capture |
| A0551 | CD301a                            | R2   | ^(BC)   | TGTATTTACTCACCG | Antibody Capture |
| A0552 | CD304 (Neuropilin-1)              | R2   | ^(BC)   | CCAGCTCATTCAACG | Antibody Capture |
| A0555 | CD36                              | R2   | ^(BC)   | TTTGCCGCTACGACA | Antibody Capture |
| A0557 | CD38                              | R2   | ^(BC)   | CGTATCCGTCTCCTA | Antibody Capture |
| A0558 | CD55 (DAF)                        | R2   | ^(BC)   | ATTGTTGTCAGACCA | Antibody Capture |
| A0559 | CD63                              | R2   | ^(BC)   | ATCCGACACGTATTA | Antibody Capture |
| A0560 | CD68                              | R2   | ^(BC)   | CTTTCTTTCACGGGA | Antibody Capture |
| A0561 | CD79b (Igβ)                       | R2   | ^(BC)   | TAACTCAGTGCGAGT | Antibody Capture |
| A0562 | CD83                              | R2   | ^(BC)   | TCTCAGGCTTCCTAG | Antibody Capture |
| A0563 | CX3CR1                            | R2   | ^(BC)   | CACTCTCAGTCCTAT | Antibody Capture |
| A0566 | CD301b                            | R2   | ^(BC)   | CTTGCCTTGCGATTT | Antibody Capture |
| A0567 | Tim-4                             | R2   | ^(BC)   | TGCTGGAGGGTATTC | Antibody Capture |
| A0568 | anti-mouse/rat XCR1               | R2   | ^(BC)   | TCCATTACCCACGTT | Antibody Capture |
| A0570 | anti-mouse/rat CD29               | R2   | ^(BC)   | ACGCATTCCTTGTGT | Antibody Capture |
| A0571 | IgD                               | R2   | ^(BC)   | TCATATCCGTTGTCC | Antibody Capture |
| A0595 | CD11a                             | R2   | ^(BC)   | AGAGTCTCCCTTTAG | Antibody Capture |
| A0807 | CD200R (OX2R)                     | R2   | ^(BC)   | ATTCTTTCCCTCTGT | Antibody Capture |
| A0809 | CD200R3                           | R2   | ^(BC)   | ATCAACTTGGAGCAG | Antibody Capture |
| A0810 | CD138 (Syndecan-1)                | R2   | ^(BC)   | GCGTTTGTATGTACT | Antibody Capture |
| A0811 | CD317 (BST2; PDCA-1)              | R2   | ^(BC)   | TGTGGTAGCCCTTGT | Antibody Capture |
| A0813 | CD9                               | R2   | ^(BC)   | TAGCAGTCACTCCTA | Antibody Capture |
| A0825 | CD371 (CLEC12A)                   | R2   | ^(BC)   | GCGAGAAATCTGCAT | Antibody Capture |
| A0827 | CD22                              | R2   | ^(BC)   | AGGTCCTCTCTGGAT | Antibody Capture |
| A0837 | IL-33Rα (IL1RL1; ST2)             | R2   | ^(BC)   | GCGATGGAGCATGTT | Antibody Capture |
| A0839 | Ly49H                             | R2   | ^(BC)   | CCAGTAGGCTTATTA | Antibody Capture |
| A0841 | Ly49D                             | R2   | ^(BC)   | TATATCCCTCAACGC | Antibody Capture |
| A0842 | Ly-49A                            | R2   | ^(BC)   | AATTCCGTCAGATGA | Antibody Capture |
| A0846 | CD185 (CXCR5)                     | R2   | ^(BC)   | ACGTAGTCACCTAGT | Antibody Capture |
| A0850 | CD49a                             | R2   | ^(BC)   | CCATTCATTTGTGGC | Antibody Capture |
| A0851 | CD1d (CD1.1; Ly-38)               | R2   | ^(BC)   | CAACTTGGCCGAATC | Antibody Capture |
| A0852 | CD226 (DNAM-1)                    | R2   | ^(BC)   | ACGCAGTATTTCCGA | Antibody Capture |
| A0854 | CD199 (CCR9)                      | R2   | ^(BC)   | CCCTCTGGTATGGTT | Antibody Capture |
| A0877 | JAML                              | R2   | ^(BC)   | GTTATGGTTCGTGTT | Antibody Capture |
| A0881 | CD272 (BTLA)                      | R2   | ^(BC)   | TGACCCTATTGAGAA | Antibody Capture |
| A0882 | PIR-A/B                           | R2   | ^(BC)   | TGTAGAGTCAGACCT | Antibody Capture |
| A0883 | CD26 (DPP-4)                      | R2   | ^(BC)   | ATGGCCTGTCATAAT | Antibody Capture |
| A0885 | CD270 (HVEM)                      | R2   | ^(BC)   | GATCCGTGTTGCCTA | Antibody Capture |
| A0892 | CD2                               | R2   | ^(BC)   | TTGCCGTGTGTTTAA | Antibody Capture |
| A0893 | CD120b (TNF R Type II/p75)        | R2   | ^(BC)   | GAAGCTGTATCCGAA | Antibody Capture |
| A0903 | CD40                              | R2   | ^(BC)   | ATTTGTATGCTGGAG | Antibody Capture |
| A0904 | CD31                              | R2   | ^(BC)   | GCTGTAGTATCATGT | Antibody Capture |
| A0905 | CD107a (LAMP-1)                   | R2   | ^(BC)   | AAATCTGTGCCGTAC | Antibody Capture |
| A0910 | anti-mouse/rat CD61               | R2   | ^(BC)   | TTCTTTACCCGCCTG | Antibody Capture |
| A0915 | VISTA (PD-1H)                     | R2   | ^(BC)   | ACATTTCCCTTGCCT | Antibody Capture |
| A0926 | CD186 (CXCR6)                     | R2   | ^(BC)   | TGTCAGGTTGTATTC | Antibody Capture |
| A0927 | CD159a (NKG2AB6)                  | R2   | ^(BC)   | GTGTTTGTGTTCCTG | Antibody Capture |
| A0930 | Ly108                             | R2   | ^(BC)   | CGATTCTTTGCGAGT | Antibody Capture |
| A1006 | CD160                             | R2   | ^(BC)   | GCGTATGTCAGTACC | Antibody Capture |
| A1007 | CD85k (gp49 Receptor)             | R2   | ^(BC)   | ATGTCAACTCTGGGA | Antibody Capture |
| A1008 | CD51                              | R2   | ^(BC)   | GGAGTCAGGGTATTA | Antibody Capture |
| A1009 | CD94                              | R2   | ^(BC)   | CACAGTTGTCCGTGT | Antibody Capture |
| A1010 | CD205 (DEC-205)                   | R2   | ^(BC)   | CATATTGGCCGTAGT | Antibody Capture |
| A1011 | CD155 (PVR)                       | R2   | ^(BC)   | TAGCTTGGGATTAAG | Antibody Capture |
| A1064 | anti-mouse/rat CD81               | R2   | ^(BC)   | TTGTCACCAACTTCC | Antibody Capture |

## `HTO_features.csv`

There are 27 samples (although not all were progressed to scRNA-seq) and
each has a unique HTO label. Specifically, we used combinatorial HTO
labelling whereby each pool is labelled with k HTOs (here k=2):

``` r
sample_metadata_df <- read_excel(
  here("data/sample_sheets/G000304_Broomfield.sample_metadata.xlsx"))
knitr::kable(sample_metadata_df)
```

| Tube | HashTag 1 | HashTag 2 | Sample    | Progressed to scRNA-seq |
|-----:|----------:|----------:|:----------|:------------------------|
|    1 |         1 |         2 | 5899      | TRUE                    |
|    2 |         2 |         3 | 5900      | TRUE                    |
|    3 |         3 |         4 | 5901      | TRUE                    |
|    4 |         4 |         5 | removed_1 | FALSE                   |
|    5 |         5 |         6 | 5903      | TRUE                    |
|    6 |         6 |         7 | 5904      | TRUE                    |
|    7 |         7 |         8 | 5905      | TRUE                    |
|    8 |         8 |         9 | 5906      | TRUE                    |
|    9 |         9 |        10 | 5908      | TRUE                    |
|   10 |        10 |        11 | 5909      | TRUE                    |
|   11 |        11 |        12 | 5910      | TRUE                    |
|   12 |        12 |        13 | removed_2 | FALSE                   |
|   13 |        13 |        14 | 5914      | TRUE                    |
|   14 |        14 |        15 | 5915      | TRUE                    |
|   15 |        15 |         1 | 5916      | TRUE                    |
|   16 |         1 |         3 | removed_3 | FALSE                   |
|   17 |         2 |         4 | removed_4 | FALSE                   |
|   18 |         5 |         7 | removed_5 | FALSE                   |
|   19 |         6 |         8 | 5912      | TRUE                    |
|   20 |         9 |        11 | 5913      | TRUE                    |
|   21 |        10 |        12 | removed_6 | FALSE                   |
|   22 |        13 |        15 | 5921      | TRUE                    |
|   23 |         1 |         8 | 5922      | TRUE                    |
|   24 |         2 |         9 | 5923      | TRUE                    |
|   25 |         3 |        10 | 5924      | TRUE                    |
|   26 |         4 |        14 | 5925      | TRUE                    |
|   27 |         5 |        12 | Cell line | TRUE                    |

Based on this, I constructed a `HTO_features.csv` file for use with
**CellRanger**.

``` r
z <- read.csv(here("data/sample_sheets/HTO_features.csv"))
# NOTE: `feature_type` must be 'Antibody Capture' rather than 
#       'Multiplexing Capture' because we're not actually using CellRanger's 
#       demultiplexing feature.
z$feature_type <- "Antibody Capture"
knitr::kable(z)
```

| id           | name         | read | pattern | sequence        | feature_type     |
|:-------------|:-------------|:-----|:--------|:----------------|:-----------------|
| Mouse_HTO_1  | Mouse_HTO_1  | R2   | 5P(BC)  | ACCCACCAGTAAGAC | Antibody Capture |
| Mouse_HTO_2  | Mouse_HTO_2  | R2   | 5P(BC)  | GGTCGAGAGCATTCA | Antibody Capture |
| Mouse_HTO_3  | Mouse_HTO_3  | R2   | 5P(BC)  | CTTGCCGCATGTCAT | Antibody Capture |
| Mouse_HTO_4  | Mouse_HTO_4  | R2   | 5P(BC)  | AAAGCATTCTTCACG | Antibody Capture |
| Mouse_HTO_5  | Mouse_HTO_5  | R2   | 5P(BC)  | CTTTGTCTTTGTGAG | Antibody Capture |
| Mouse_HTO_6  | Mouse_HTO_6  | R2   | 5P(BC)  | TATGCTGCCACGGTA | Antibody Capture |
| Mouse_HTO_7  | Mouse_HTO_7  | R2   | 5P(BC)  | GAGTCTGCCAGTATC | Antibody Capture |
| Mouse_HTO_8  | Mouse_HTO_8  | R2   | 5P(BC)  | TATAGAACGCCAGGC | Antibody Capture |
| Mouse_HTO_9  | Mouse_HTO_9  | R2   | 5P(BC)  | TGCCTATGAAACAAG | Antibody Capture |
| Mouse_HTO_10 | Mouse_HTO_10 | R2   | 5P(BC)  | CCGATTGTAACAGAC | Antibody Capture |
| Mouse_HTO_11 | Mouse_HTO_11 | R2   | 5P(BC)  | GCTTACCGAATTAAC | Antibody Capture |
| Mouse_HTO_12 | Mouse_HTO_12 | R2   | 5P(BC)  | CTGCAAATATAACGG | Antibody Capture |
| Mouse_HTO_13 | Mouse_HTO_13 | R2   | 5P(BC)  | CTACATTGCGATTTG | Antibody Capture |
| Mouse_HTO_14 | Mouse_HTO_14 | R2   | 5P(BC)  | CTTTCGCCAACTCTG | Antibody Capture |
| Mouse_HTO_15 | Mouse_HTO_15 | R2   | 5P(BC)  | CCCTCTCTGGATTCT | Antibody Capture |

## `features.csv`

We concatenate `ADT_features.csv` and `HTO_features.csv` to generate
`features.csv`.

``` r
features <- rbind(y, z)
write.csv(
  features,
  file = here("data", "sample_sheets", "features.csv"),
  row.names = FALSE,
  quote = TRUE)
```
