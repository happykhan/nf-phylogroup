#!/bin/bash
#SBATCH --job-name=nextflow_job
#SBATCH --partition=short,long
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=8:00:00
#SBATCH --output=nextflow.out
#SBATCH --error=nextflow.err

# Set the working directory
cd ~/nf-phylotyping
module load Java/17.0.4
# Run Nextflow
./nextflow run main.nf -profile bmrc --output_dir test_data
