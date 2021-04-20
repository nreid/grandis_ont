#!/bin/bash 
#SBATCH --job-name=comb
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --mem=5G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=noah.reid@gmail.com
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err



# input/output files, directories
cat ../../results/fastas/female.fasta ../../results/fastas/male.fasta >../../results/fastas/combined.fasta