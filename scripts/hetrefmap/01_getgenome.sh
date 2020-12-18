#!/bin/bash
#SBATCH --job-name=getgenome
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 10
#SBATCH --mem=5G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=first.last@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err


hostname
date

# load software

module load bwa/0.7.17	
module load samtools/1.10
module load ngmlr/0.2.7
module load minimap2/2.17

# input/output files, directories

GENOMEDIR=../../genome
mkdir -p $GENOMEDIR

# download new fundulus genome assembly from:
	# https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/011/125/445/GCF_011125445.2_MU-UCD_Fhet_4.1/

wget -P $GENOMEDIR https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/011/125/445/GCF_011125445.2_MU-UCD_Fhet_4.1/GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.fna.gz
wget -P $GENOMEDIR https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/011/125/445/GCF_011125445.2_MU-UCD_Fhet_4.1/GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.gff.gz
wget -P $GENOMEDIR https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/011/125/445/GCF_011125445.2_MU-UCD_Fhet_4.1/GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.gtf.gz

# decompress the genome
gunzip $GENOMEDIR/GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.fna.gz

# index the genome using samtools
samtools faidx $GENOMEDIR/GCF_011125445.2_MU-UCD_Fhet_4.1_genomic.fna


