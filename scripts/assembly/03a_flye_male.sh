#!/bin/bash
#SBATCH --job-name=flye_male
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 24
#SBATCH --partition=himem2
#SBATCH --qos=himem
#SBATCH --mail-type=ALL
#SBATCH --mem=900G
#SBATCH --mail-user=noah.reid@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

# load software
module load flye/2.8.2

FASTA=../../results/fastas/male_wfails.fasta

OUTDIR=../../results/flye_male_wfails


# run flye
	# consider "--keep-haplotypes" option
	# check to see if hybrid ancestry haplotigs are output

flye --nano-raw $FASTA --out-dir $OUTDIR --threads 24
