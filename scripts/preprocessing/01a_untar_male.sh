#!/bin/bash 
#SBATCH --job-name=untar_1
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

tar -xvf ../../../rawdata/male/2019DEC18_NoahReid_Liver_Male_LSK109_PAE07898.tar.gz