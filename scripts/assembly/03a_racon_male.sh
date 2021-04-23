#!/bin/bash
#SBATCH --job-name=medaka_male
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
module load racon/1.4.21

# input/output files, directories
NPROC=$(nproc)
RAW=../../results/fastas/male.fasta
DRAFT=../../results/shasta_male_v0.7.0/Assembly.fasta
MAP=

OUTDIR=../../results/shasta_male_v0.7.0/medaka_consensus

racon 


# run medaka
	# guppy 3.2.6
MODEL=r941_prom_high_g303
medaka_consensus -i ${FASTA} -d ${DRAFT} -o ${OUTDIR} -t ${NPROC} -m ${MODEL}



