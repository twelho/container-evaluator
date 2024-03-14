#!/bin/bash -l
#SBATCH --job-name=container-evaluator
#SBATCH --account=<project>
#SBATCH --time=00:10:00
#SBATCH --mem-per-cpu=2G
#SBATCH --partition=small

srun ./evaluator.sh > "output-$(date +%F_%H-%M-%S).txt"
