#!/bin/bash
#SBATCH --job-name=1400k
#SBATCH --time=1:0:0
#SBATCH --nodes=1
#SBATCH --tasks-per-node=128
#SBATCH --cpus-per-task=1

#SBATCH --partition=standard
#SBATCH --qos=standard
#SBATCH --account=z19

module load gromacs

export OMP_NUM_THREADS=1

nodes=$SLURM_JOB_NUM_NODES
casename="benchmark"

cpn=128
mdrun="gmx_mpi mdrun"

cores=$(( nodes * cpn ))
timestamp=$(date '+%Y%m%d%H%M')
resfile="${casename}_${nodes}nodes_${timestamp}"

MPI_LAUNCH="srun --hint=nomultithread --distribution=block:block"

${MPI_LAUNCH} ${mdrun} -s ${casename}.tpr -g ${resfile} -noconfout

rm ener.edr

