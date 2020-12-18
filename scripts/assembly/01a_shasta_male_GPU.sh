#!/bin/bash
#SBATCH --job-name=shasta_assembly_male
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 36
#SBATCH --partition=himem2
#SBATCH --qos=himem
#SBATCH --mail-type=ALL
#SBATCH --mem=500G
#SBATCH --mail-user=noah.reid@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

# to run 
module load singularity/3.5.2
module load shasta/0.4.0

SHASTA_GPU=/isg/shared/apps/shasta/0.4.0/shasta_gpu

FASTA=../../results/fastas/male.fasta

OUTDIR=../../results/shasta_male_GPU
rm -r $OUTDIR

# shasta requires uncompressed fasta
$SHASTA_GPU \
--input $FASTA  \
--assemblyDirectory $OUTDIR \
--Reads.minReadLength 500 \
--memoryMode anonymous \
--memoryBacking 4K \
--threads 36 \
--useGpu
