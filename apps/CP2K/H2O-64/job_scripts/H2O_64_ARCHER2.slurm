#!/bin/bash

# Slurm job options (name, compute nodes, job time)
#SBATCH --job-name=bench
#SBATCH --time=0:20:0
#SBATCH --exclusive
#SBATCH --nodes=4
#SBATCH --tasks-per-node=64
#SBATCH --cpus-per-task=2
#SBATCH --qos=standard
#SBATCH --partition=standard

# Replace [budget code] below with your budget code (e.g. t01)
#SBATCH --account=z19


module load epcc-job-env
module load cp2k/7.1

export EXE=cp2k.psmp

export OMP_NUM_THREADS=2
NODES=$SLURM_JOB_NUM_NODES
CORES=$((NODES*128))
THREADS=$OMP_NUM_THREADS


export OMP_PLACES=cores

srun --hint=nomultithread --distribution=block:block $EXE -i H2O-64.inp  > H2O_bench-${NODES}nodes-${CORES}cores-${THREADS}threads-run${i}.out
