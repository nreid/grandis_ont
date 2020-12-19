#!/bin/bash
#SBATCH --job-name=sniffles_male
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 15
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mem=25G
#SBATCH --mail-user=noah.reid@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

# load software
module load htslib/1.10.2
SNIFFLES=~/bin/Sniffles-master/bin/sniffles-core-1.0.12/sniffles


# input/output dirs, files

INFILE=/projects/EBP/CBC/Reid_promethion/grandis_ont/results/hetrefmap/male.minimap.bam

OUTDIR=../../results/hetrefmap_SVs/
mkdir -p $OUTDIR


# run sniffles
$SNIFFLES -t 15 -m $INFILE -v $OUTDIR/male_minimap.vcf

# compress and index
bgzip $OUTDIR/male_minimap.vcf
tabix -p vcf $OUTDIR/male_minimap.vcf.gz

