#!/bin/bash
#SBATCH --job-name=map_reads
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 15
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mem=25G
#SBATCH --mail-user=noah.reid@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

# load software
module load minimap2/2.17
module load samtools/1.10

# input/output dirs, files

INDIR=/projects/EBP/CBC/Reid_promethion/rawdata/male/2019DEC18_NoahReid_Liver_Male_LSK109_PAE07898/20191218_2053_1-E1-H1_PAE07898_da2cecfc/

OUTDIR=../../results/hetrefmap/
mkdir -p $OUTDIR

GENOME=../../genome/GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.fna

# run minimap2

cat $(find $INDIR -name "*fastq" | sort) | \
minimap2 -ax map-ont -t 10 $GENOME - | \
samtools sort -@ 5 -T male -O BAM \
>$OUTDIR/male.minimap.bam

samtools index $OUTDIR/male.minimap.bam