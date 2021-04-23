#!/bin/bash
#SBATCH --job-name=medaka_male
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 12
#SBATCH --partition=himem
#SBATCH --qos=himem
#SBATCH --mail-type=ALL
#SBATCH --mem=300G
#SBATCH --mail-user=noah.reid@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date


# load software
module load racon/1.4.21

# input/output files, directories
NPROC=$(nproc)
RAW=../../results/fastqs/male.fastq.gz
MAP=../../results/mapped_reads/male.minimap.sam
DRAFT=../../results/shasta_male_v0.7.0/Assembly.fasta

OUTDIR=../../results/shasta_male_v0.7.0/racon_consensus

# run racon
racon -t 12 $RAW $MAP $DRAFT >$OUTDIR/racon.fasta


