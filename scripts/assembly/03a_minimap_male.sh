#!/bin/bash
#SBATCH --job-name=map_reads
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 24
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mem=25G
#SBATCH --mail-user=noah.reid@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

# load software
module load minimap2/2.17
module load samtools/1.10

# input/output
GENOME=../../results/shasta_male_v0.7.0/Assembly.fasta
FASTQ=../../results/fastqs/male.fastq.gz

OUTDIR=../../results/mapped_reads
mkdir -p $OUTDIR

# run
minimap2 -ax map-ont --MD -t 24 $GENOME $FASTQ >$OUTDIR/male.minimap.sam

samtools sort -@ 5 -T $OUTDIR/male.minimap -O BAM $OUTDIR/male.minimap.sam >$OUTDIR/male.minimap.bam

samtools index $OUTDIR/male.minimap.bam