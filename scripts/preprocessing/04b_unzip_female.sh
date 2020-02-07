#!/bin/bash 
#SBATCH --job-name=unzip_female
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

# shasta requires unzipped fasta files

gzip -d -c ../../results/fastas/female.fasta.gz >../../results/fastas/female.fasta

