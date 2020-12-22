#!/bin/bash 
#SBATCH --job-name=makefastas
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


module load blast/2.7.1

# input/output files, directories
INDIR=../../results/shasta_male_himem2
INFILE=../../results/shasta_male_himem2/Assembly.fasta

OUTDIR=../../results/shasta_male_himem2-blastdb
mkdir -p $OUTDIR


makeblastdb -in $INFILE \
-dbtype nucl \
-title shasta_male.blastdb \
-parse_seqids \
-out $OUTDIR/shasta_male.blastdb

# to search: 

# blastn -db db.name -query query.fasta -out results.out

# to extract a sequence from the database:

# blastdbcmd -db grandis_ont/results/fastas/male.blastdb -entry d69f42fe-4e03-4710-8ae5-05c2d8b51bf2 -outfmt %f -out amhy_male_1hit.fasta