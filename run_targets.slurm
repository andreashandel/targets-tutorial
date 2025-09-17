#!/bin/bash
#SBATCH --job-name=targets_job           # name of job
#SBATCH --partition=batch                # partition/queue
#SBATCH --nodes=1                        # number of nodes
#SBATCH --ntasks=1                       # number of tasks
#SBATCH --cpus-per-task=8                # number of CPU cores
#SBATCH --mem=32G                        # memory allocation
#SBATCH --time=24:00:00                  # max runtime (HH:MM:SS)
#SBATCH --output=targets_%j.out          # standard output log
#SBATCH --error=targets_%j.err           # standard error log

# load R
module load R/4.4.2-gfbf-2024a

# I had to install some packages that require these
module load GCC/13.2.0 # loads GCC
module load GSL # loads GSL
module load CMake/3.27.6-GCCcore-13.2.0 # loads CMake

# change directory to your project folder
cd /scratch/mhj73579/targets-tutorial

# run the targets pipeline in R
Rscript -e "library(targets); tar_make()"
