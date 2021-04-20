#!/bin/bash
#SBATCH --job-name=shasta_v0.7.0_combined
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 36
#SBATCH --partition=himem
#SBATCH --qos=himem
#SBATCH --mail-type=ALL
#SBATCH --mem=500G
#SBATCH --mail-user=noah.reid@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

module load shasta/0.7.0

FASTA=../../results/fastas/combined.fasta

OUTDIR=../../results/shasta_combined_v0.7.0
rm -r $OUTDIR

# shasta requires uncompressed fasta
shasta \
--input $FASTA  \
--assemblyDirectory $OUTDIR \
--Reads.minReadLength 500 \
--memoryMode anonymous \
--memoryBacking 4K \
--threads 36 \
--Assembly.detangleMethod 1