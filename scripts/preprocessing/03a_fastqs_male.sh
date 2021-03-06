#!/bin/bash 
#SBATCH --job-name=catfastqs_f
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
INDIR=../../../rawdata/male/2019DEC18_NoahReid_Liver_Male_LSK109_PAE07898/20191218_2053_1-E1-H1_PAE07898_da2cecfc/fastq_pass

OUTDIR=../../results/fastqs
mkdir -p $OUTDIR

OUTFILE=male.fastq.gz

# concatenate fastqs
for file in $INDIR/*fastq; do cat $file; done | \
gzip >$OUTDIR/$OUTFILE

