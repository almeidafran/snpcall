#!/bin/bash
ref="/home/almeidafran/directory_file_reference_genome_index/reference_genome.fna"

ls /home/almeidafran/directory_bam_file/*_sorted_rg.bam > bam.fofn
/home/cluster/programas/anaconda2/bin/freebayes \
  --fasta-reference ${ref} \
  --bam-list bam.fofn \
  --vcf output.vcf \
