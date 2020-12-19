#!/bin/bash
#SBATCH --job-name=ngmlr_m
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 15
#SBATCH --mem=15G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=first.last@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

# load software

module load ngmlr/0.2.7
module load samtools/1.9

# input/output dirs, files

INDIR=/projects/EBP/CBC/Reid_promethion/rawdata/male/2019DEC18_NoahReid_Liver_Male_LSK109_PAE07898/20191218_2053_1-E1-H1_PAE07898_da2cecfc/

OUTDIR=../../results/hetrefmap/
mkdir -p $OUTDIR

GENOME=../../genome/GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.fna

# run ngmlr

cat $(find $INDIR -name "*fastq" | sort) | \
ngmlr --bam-fix -t 10 -r $GENOME -q /dev/stdin -o stdout -x ont | \
samtools sort -@ 5 -T male -O BAM \
>$OUTDIR/male.ngmlr.bam

samtools index $OUTDIR/male.ngmlr.bam