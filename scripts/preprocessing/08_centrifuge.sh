#!/bin/bash
#SBATCH --job-name=centrifuge
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --partition=himem
#SBATCH --qos=himem
#SBATCH --mail-type=END
#SBATCH --mem=200G
#SBATCH --mail-user=
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err


hostname
date

# load software
module load centrifuge/1.0.4-beta

#input/output files, directories
MFASTA=../../results/fastas/male.fasta
FFASTA=../../results/fastas/female.fasta

OUTDIR=../../resuts/centrifuge

centrifuge -f \
        -x /isg/shared/databases/centrifuge/b+a+v+h/p_compressed+h+v \
        --report-file $OUTDIR/male_report.tsv \
        --quiet \
        --min-hitlen 50 \
        -U $MFASTA

centrifuge -f \
        -x /isg/shared/databases/centrifuge/b+a+v+h/p_compressed+h+v \
        --report-file $OUTDIR/female_report.tsv \
        --quiet \
        --min-hitlen 50 \
        -U $FFASTA

date