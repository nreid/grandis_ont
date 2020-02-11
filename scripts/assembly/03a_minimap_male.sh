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


module load minimap2/2.17

GENOME=../../results/shasta_male_himem2/Assembly.fasta
FASTQ=../../results/fastqs/male.fastq.gz

OUTDIR=../../results/mapped_reads
mkdir -p $OUTDIR

OUTFILE=male.sam

minimap2 \
-ax map-ont \
-t 24 \
$GENOME \
$FASTQ >$OUTDIR/$OUTFILE

