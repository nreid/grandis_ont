#!/bin/bash
#SBATCH --job-name=assembly_nfpipe
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mem=5G
#SBATCH --mail-user=
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

module load nextflow/22.04.0

nextflow run \
    main.nf \
    --fasta /core/projects/EBP/CBC/Reid_promethion/grandis_ont/results/fastas/male.fasta \
    --fastq /core/projects/EBP/CBC/Reid_promethion/grandis_ont/results/fastqs/male.fastq.gz \
    --resume
