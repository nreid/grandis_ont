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

OUTDIR=../../results/shasta_male_himem2_v4
rm -r $OUTDIR

# shasta requires uncompressed fasta

# in this run, I modify the _guppy3 run and lower the required number of markers, --Align.minAlignedMarkerCount to 50 from the default 100
	# per this github issue: https://github.com/chanzuckerberg/shasta/issues/61
	# 100 markers ~ 3kb sequence, so 3kb winds up being the minimum length of usable sequence
# I am also increasing the iteration count for the minhash algorithm from 10 to 20
	# this should find more read overlaps. 

shasta \
--input $FASTA  \
--assemblyDirectory $OUTDIR \
--Reads.minReadLength 500 \
--memoryMode anonymous \
--memoryBacking 4K \
--threads 36 \
--Assembly.consensusCaller Bayesian:guppy-3.0.5-a \
--Align.minAlignedMarkerCount 50 \
--MinHash.minHashIterationCount 20