#!/bin/bash
#SBATCH --job-name=shasta_assembly_male
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

module load shasta/0.4.0

FASTA=../../results/fastas/male.fasta

OUTDIR=../../results/shasta_male_himem2_guppy3
rm -r $OUTDIR

# shasta requires uncompressed fasta
shasta \
--input $FASTA  \
--assemblyDirectory $OUTDIR \
--Reads.minReadLength 500 \
--memoryMode anonymous \
--memoryBacking 4K \
--threads 36 \
--Assembly.consensusCaller Bayesian:guppy-3.0.5-a
