#!/bin/bash
#SBATCH --job-name=1400k
#SBATCH --time=3:0:0
#SBATCH --nodes=1
#SBATCH --tasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --exclusive

module restore /lus/cls01095/work/z19/z19/aturner/.module/PrgEnv-gnu
export MODULEPATH=/lus/cls01095/work/z19/z19/aturner/privatemodules:$MODULEPATH
module load gromacs

export OMP_NUM_THREADS=1

nodes=$SLURM_JOB_NUM_NODES
casename="benchmark"

cpn=128
mdrun="gmx_mpi mdrun"

cores=$(( nodes * cpn ))
timestamp=$(date '+%Y%m%d%H%M')
resfile="${casename}_${nodes}nodes_${timestamp}"

MPI_LAUNCH="srun --cpu-bind=cores"

${MPI_LAUNCH} ${mdrun} -s ${casename}.tpr -g ${resfile} -noconfout

rm ener.edr

