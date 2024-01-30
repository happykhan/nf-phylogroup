#!/bin/bash
#SBATCH --job-name=nextflow_job
#SBATCH --partition=short,long
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1:00:00
#SBATCH --output=nextflow.out
#SBATCH --error=nextflow.err

# Load required modules
module load Nextflow/23.04.2

# Set the working directory
cd ~/nf-phylotyping

# Run Nextflow
nextflow run main.nf 
