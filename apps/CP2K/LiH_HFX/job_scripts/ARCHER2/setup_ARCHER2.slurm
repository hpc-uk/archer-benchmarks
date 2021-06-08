#!/bin/bash

# Slurm job options (name, compute nodes, job time)
#SBATCH --job-name=cp2k_bench
#SBATCH --time=0:30:0
#SBATCH --nodes=2
#SBATCH --tasks-per-node=16
#SBATCH --cpus-per-task=8
#SBATCH --qos=standard
#SBATCH --partition=standard

# Replace [budget code] below with your budget code (e.g. t01)
#SBATCH --account=z19


module load epcc-job-env
module load cp2k

export OMP_NUM_THREADS=8
export EXE=cp2k.psmp

NODES=$SLURM_JOB_NUM_NODES
CORES=$((NODES*128))
THREADS=$OMP_NUM_THREADS

export OMP_PLACES=cores


srun --hint=nomultithread --distribution=block:block $EXE -i input_bulk_B88_3.inp  > HFX_setup.out

