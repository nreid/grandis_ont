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
INDIR=../../../rawdata/female/2019DEC18_NoahReid_Liver_female_LSK109_PAE07894/20191218_2053_1-A1-D1_PAE07894_18186954/fastq_pass

OUTDIR=../../results/fastqs
mkdir -p $OUTDIR

OUTFILE=female.fastq.gz

# concatenate fastqs
for file in $INDIR/*fastq; do cat $file; done | \
gzip >$OUTDIR/$OUTFILE

