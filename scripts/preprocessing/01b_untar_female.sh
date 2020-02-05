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

tar -xvf ../../../rawdata/female/2019DEC18_NoahReid_Liver_female_LSK109_PAE07894.tar.gz