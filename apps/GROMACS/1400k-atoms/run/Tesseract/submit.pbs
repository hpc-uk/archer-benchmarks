#!/bin/bash --login
#
#PBS -N GROMACS_1400k
#PBS -l select=16
#PBS -l walltime=1:0:0
#PBS -l place=scatter:excl
#PBS -A z01

module load intel-tools-18
module load gcc

cd $PBS_O_WORKDIR

nodes=1
casename="benchmark"

cpn=24
GMXDIR=/home/z01/z01/dc-turn1/software/GROMACS/gromacs-2018.1
mdrun=${GMXDIR}/build_mpi/bin/mdrun_mpi

cores=$(( nodes * cpn ))
timestamp=$(date '+%Y%m%d%H%M')
resfile="${casename}_${nodes}nodes_${timestamp}"

# export I_MPI_PIN_DOMAIN=omp
export OMP_NUM_THREADS=1
mpirun -n ${cores} -ppn ${cpn} -f ${PBS_NODEFILE} ${mdrun} -s ${casename}.tpr -g ${resfile} -noconfout

rm ener.edr

