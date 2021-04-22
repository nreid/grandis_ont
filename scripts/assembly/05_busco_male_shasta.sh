#!/bin/bash
#SBATCH --job-name=busco_flye
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --mem=5G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=firs.name@uconn.edu
#SBATCH -o %x_%A.out
#SBATCH -e %x_%A.err

hostname
date

# load software
module load busco/4.0.2

# input/output files
GENOME=../../results/shasta_male_v0.7.0/medaka_consensus/consensus.fasta
DATABASE=/isg/shared/databases/BUSCO/odb10/lineages/actinopterygii_odb10

OUTPREFIX=male_shasta
OUTDIR=../../results/busco
mkdir -p $OUTDIR

export AUGUSTUS_CONFIG_PATH=../../augustus/config 

busco \
	-i $GENOME \
	-o $OUTPREFIX \
	-l $DATABASE \
	-m genome


