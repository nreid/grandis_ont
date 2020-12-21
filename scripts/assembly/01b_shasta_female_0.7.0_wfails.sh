#!/bin/bash
#SBATCH --job-name=shasta_v0.7.0_female_wfails
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 36
#SBATCH --partition=himem2
#SBATCH --qos=himem
#SBATCH --mail-type=ALL
#SBATCH --mem=900G
#SBATCH --mail-user=noah.reid@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

module load shasta/0.7.0

FASTA=../../results/fastas/female_wfails.fasta

OUTDIR=../../results/shasta_female_v0.7.0_wfails
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