#!/bin/bash -l
#SBATCH --job-name=container-evaluator
#SBATCH --account=<project>
#SBATCH --partition=gputest
#SBATCH --time=00:01:00
##SBATCH --nodes=1
##SBATCH --ntasks-per-node=1
##SBATCH --cpus-per-task=1
##SBATCH --mem-per-cpu=2G
#SBATCH --output=output.txt

srun ./evaluator.sh
#srun ./evaluator.sh > "output-$(date +%F_%H-%M-%S).txt"
