#!/bin/bash
#SBATCH --job-name=nextflow_job
#SBATCH --partition=short,long
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=2:00:00
#SBATCH --output=nextflow.out
#SBATCH --error=nextflow.err

# Set the working directory
cd ~/nf-phylotyping

# Run Nextflow
<<<<<<< HEAD
nextflow run main.nf -profile bmrc
=======
./nextflow run main.nf -profile bmrc
>>>>>>> d3a53e76d0a4f0faf5dfe6990cdc8b022b10b281
