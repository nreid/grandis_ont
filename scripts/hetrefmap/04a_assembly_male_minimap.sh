#!/bin/bash
#SBATCH --job-name=minimap_assembly_male
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
module load samtools/1.9

# input/output dirs, files

# this assembly has decent N50
# INDIR=/projects/EBP/CBC/Reid_promethion/grandis_ont/results/shasta_male_himem2
INDIR=/projects/EBP/CBC/Reid_promethion/grandis_ont/results/shasta_male_v0.7.0/medaka_consensus

OUTDIR=../../results/hetrefmap/
mkdir -p $OUTDIR

GENOME=../../genome/GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.fna

# run minimap2
minimap2 -c --MD -ax map-ont -t 10 $GENOME $INDIR/consensus.fasta | \
samtools sort -@ 5 -T $OUTDIR/male.assembly.minimap -O BAM \
>$OUTDIR/male.assembly.minimap.bam

samtools index $OUTDIR/male.assembly.minimap.bam