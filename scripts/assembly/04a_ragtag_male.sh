#!/bin/bash
#SBATCH --job-name=ragtag_male
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 12
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mem=60G
#SBATCH --mail-user=noah.reid@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date


# load software
# installed in user home
source ~/miniconda3/etc/profile.d/conda.sh 
conda activate ragtag

#input/output

OUTDIR=../../results/shasta_male_v0.7.0/ragtag_scaffold/
mkdir -p $OUTDIR

QUERY=../../results/shasta_male_v0.7.0/medaka_consensus/consensus.fasta
REFERENCE=../../genome/GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.fna

# correct
ragtag.py correct -o $OUTDIR -u -t 12 --inter $REFERENCE $QUERY

# scaffold
ragtag.py scaffold -o $OUTDIR -u -t 12 $REFERENCE $OUTDIR/consensus.corrected.fasta
