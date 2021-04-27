#!/bin/bash
#SBATCH --job-name=purge_haplotigs_1
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --mem=60G
#SBATCH --partition=xeon
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

# load software
module load purge_haplotigs/1.0

# input/output
OUTDIR=../../results/male_purgehaplotigs
mkdir -p $OUTDIR

# purge haplotigs doesn't allow specifying the output directory, so go to OUTDIR
cd $OUTDIR

BAM=../mapped_reads/male.minimap.bam
GENOME=../shasta_male_v0.7.0/medaka_racon_consensus/consensus.fasta

## purge_haplotigs  readhist  -b aligned.bam  -g genome.fasta  [ -t threads ]
purge_haplotigs readhist -b $BAM -g $GENOME -t 16
