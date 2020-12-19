#!/bin/bash
#SBATCH --job-name=minimap_female
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

INDIR=/projects/EBP/CBC/Reid_promethion/rawdata/female/2019DEC18_NoahReid_Liver_female_LSK109_PAE07894/20191218_2053_1-A1-D1_PAE07894_18186954/

OUTDIR=../../results/hetrefmap/
mkdir -p $OUTDIR

GENOME=../../genome/GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.fna

# run minimap2

cat $(find $INDIR -name "*fastq" | sort) | \
minimap2 -ax map-ont -t 10 $GENOME - | \
samtools sort -@ 5 -T female -O BAM \
>$OUTDIR/female.minimap.bam

samtools index $OUTDIR/female.minimap.bam