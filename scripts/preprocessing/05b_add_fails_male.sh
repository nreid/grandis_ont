#!/bin/bash 
#SBATCH --job-name=addfails_male
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

# software, files etc
bioawk=~/bin/bioawk/bioawk
FAILDIR=/projects/EBP/CBC/Reid_promethion/rawdata/male/2019DEC18_NoahReid_Liver_Male_LSK109_PAE07898/20191218_2053_1-E1-H1_PAE07898_da2cecfc/fastq_fail
OUTDIR=../../results/fastas/
# add failed fasta records 

cat \
$OUTDIR/male.fasta \
<(cat $FAILDIR/*fastq | $bioawk -c fastx '{if(length($seq) > 30000) print ">"$name "\n" $seq}') \
>$OUTDIR/male_wfails.fasta

