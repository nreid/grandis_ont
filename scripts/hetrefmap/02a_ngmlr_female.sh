#!/bin/bash
#SBATCH --job-name=ngmlr_f
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
module load samtools/1.10

# input/output dirs, files

INDIR=/projects/EBP/CBC/Reid_promethion/rawdata/female/2019DEC18_NoahReid_Liver_female_LSK109_PAE07894/20191218_2053_1-A1-D1_PAE07894_18186954/

OUTDIR=../../results/hetrefmap/
mkdir -p $OUTDIR

GENOME=../../genome/GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.fna

# run ngmlr

cat $(find $INDIR -name "*fastq" | sort) | \
ngmlr --bam-fix -t 10 -r $GENOME -q /dev/stdin -o stdout -x ont | \
samtools sort -@ 5 -T female -O BAM \
>$OUTDIR/female.bam

samtools index $OUTDIR/female.bam