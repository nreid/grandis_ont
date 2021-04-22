#!/bin/bash
#SBATCH --job-name=nanoplot
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 10
#SBATCH --mem=50G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

echo "HOSTNAME: `hostname`"
echo "Start Time: `date`"

# load software
module load NanoPlot/1.21.0

#input/output files
MALE=../../results/fastqs/male.fastq.gz
FEMALE=../../results/fastqs/female.fastq.gz

MOUT=../../results/nanoplot/male
mkdir -p $MOUT
FOUT=../../results/nanoplot/female
mkdir -p $FOUT

# run nanoplot
#male
NanoPlot --fastq $MALE \
        --loglength \
        -o $MOUT \
        -t 10

#female
NanoPlot --fastq $FEMALE \
        --loglength \
        -o $FOUT \
        -t 10
