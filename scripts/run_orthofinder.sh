#!/bin/bash
#$ -N orthofinder_job          # Job name
#$ -o /Users/jayelazuno/orthofinder_output/job_output.txt  # Redirect standard output
#$ -e /Users/jayelazuno/orthofinder_output/job_error.txt   # Redirect standard error
#$ -cwd                       # Run the job from the current working directory
#$ -l h_vmem=16G              # Request 16GB of memory per core
#$ -pe smp 8                  # Request 8 CPU cores for parallel execution
#$ -m bea                     # Send email at the start, end, and if the job is aborted
#$ -M jayelazuno@uiowa.edu   # Email address for notifications

# Activate the OrthoFinder conda environment
source ~/anaconda3/bin/activate orthofinder_env

# Run OrthoFinder
orthofinder -f /Users/jayelazuno/orthofinder_data -t 8

# Deactivate the environment after the job completes
conda deactivate
