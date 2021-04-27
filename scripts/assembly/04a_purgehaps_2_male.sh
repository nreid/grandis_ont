#!/bin/bash
#SBATCH --job-name=purge_haplotigs_2
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
module load R/4.0.3
# input/output
OUTDIR=../../results/male_purgehaplotigs
mkdir -p $OUTDIR

# purge haplotigs doesn't allow specifying the output directory, so go to OUTDIR
cd $OUTDIR

# run purge haplotigs step 2
purge_haplotigs  contigcov  -i male.minimap.bam.gencov  -l 10  -m 26  -h 100

