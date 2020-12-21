#!/bin/bash 
#SBATCH --job-name=addfails_female
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

hostname
date

# software, files etc
bioawk=~/bin/bioawk/bioawk
FAILDIR=/projects/EBP/CBC/Reid_promethion/rawdata/female/2019DEC18_NoahReid_Liver_female_LSK109_PAE07894/20191218_2053_1-A1-D1_PAE07894_18186954/fastq_fail
OUTDIR=../../results/fastas/
# add failed fasta records 

cat \
$OUTDIR/female.fasta \
<(cat $FAILDIR/*fastq | $bioawk -c fastx '{if(length($seq) > 30000) print ">"$name "\n" $seq}') \
>$OUTDIR/female_wfails.fasta

