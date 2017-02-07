# gene_expression
Storage for basic RNASeq expression code

This repository documents code used in the stricker lab to analyze RNASeq datasets. 

Data from TCGA: use gdc-client to download files from the data commons. 

Data is aligned to HG38 with two-pass STAR

3 files/sample -- htseq.counts, FPKM, and FPKM-UQ (upper quantile -- normalized across samples by diviing each sample by the UQ)
Choose the files fit for your experiment.


