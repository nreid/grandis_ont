#!/bin/bash
#SBATCH --job-name=sort_reads
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 12
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mem=15G
#SBATCH --mail-user=noah.reid@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

module load samtools/1.9

INDIR=../../results/mapped_reads
INFILE=male.sam
OUTFILE=male.bam

samtools sort \
-@ 12 \
-O bam \
-o $INDIR/$OUTFILE \
$INDIR/$INFILE