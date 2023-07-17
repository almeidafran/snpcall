#!/bin/bash

#Single-end
for f1 in ~/shared/almeidafran/0_data/*.FASTQ.gz
do 

TrimmomaticSE -threads 24 -phred33 $f1 ${f1%%.FASTQ.gz}"trimmed_.fq.gz" ILLUMINACLIP:Sequencing_adaptors.fasta:2:30:7 LEADING:7 HEADCROP:16 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:40 

done

