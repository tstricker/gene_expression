# gene_expression
Storage for basic RNASeq expression code

This repository documents code used in the stricker lab to analyze RNASeq datasets. 

Data from TCGA: use gdc-client to download files from the data commons. 

Data is aligned to HG38 with two-pass STAR

3 files/sample -- htseq.counts, FPKM, and FPKM-UQ (upper quantile -- normalized across samples by diviing each sample by the UQ)
Choose the files fit for your experiment.

metadata.parser.pl -- needs to be run first. Input is the manifest json. Output is a file that links file name to TCGA ID -- tcga.2.file.txt. Is used to order the expression and clincial tables. 

xml.parser.pl -- run second. Input is the clinical file from GDC and tcga.2.file.txt. Output is BLAH.clinical.txt. May require some modifcation t oensure proper regex selection. 

expression.table.creation.pl -- will generate the expression table from the expression files downloaded from GDC. Inputs are the expression tables, tcga.2.file.txt, and BLAH.clinical.txt


