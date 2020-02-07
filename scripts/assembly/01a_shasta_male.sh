#!/bin/bash
#SBATCH --job-name=shasta_assembly_male
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 64
#SBATCH --partition=himem
#SBATCH --qos=himem
#SBATCH --mail-type=ALL
#SBATCH --mem=500G
#SBATCH --mail-user=noah.reid@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

module load shasta/0.2.0

FASTA=../../results/fastas/male.fasta

OUTDIR=../../shasta_male
rm -r $OUTDIR

# shasta requires uncompressed fasta
shasta \
--input $FASTA  \
 --assemblyDirectory $OUTDIR \
--Reads.minReadLength 500 \
--memoryMode anonymous \
--memoryBacking 4K \
--threads 64