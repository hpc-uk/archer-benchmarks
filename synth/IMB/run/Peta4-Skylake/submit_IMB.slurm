#!/bin/bash
#SBATCH -J gmx_bench
#SBATCH -A T2BENCH-SL2-CPU
#SBATCH --nodes=4
#SBATCH --ntasks=128
#SBATCH --time=1:0:0
#SBATCH --no-requeue
#SBATCH -p skylake

#! Number of nodes and tasks per node allocated by SLURM (do not change):
numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')

#! Optionally modify the environment seen by the application
#! (note that SLURM reproduces the environment at submission irrespective of ~/.bashrc):
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module add dot slurm turbovnc vgl singularity 
module add rhel7/global 
module add intel/bundles/complib/2019.3

#! Work directory (i.e. where the job will run):
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.

#! Are you using OpenMP (NB this is unrelated to OpenMPI)? If so increase this
#! safe value to no more than 16:
export OMP_NUM_THREADS=1

#! Number of MPI tasks to be started by the application per node and in total (do not change):
np=$[${numnodes}*${mpi_tasks_per_node}]

#! The following variables define a sensible pinning strategy for Intel MPI tasks -
#! this should be suitable for both pure MPI and hybrid MPI/OpenMP jobs:
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
#! Notes:
#! 1. These variables influence Intel MPI only.
#! 2. Domains are non-overlapping sets of cores which map 1-1 to MPI tasks.
#! 3. I_MPI_PIN_PROCESSOR_LIST is ignored if I_MPI_PIN_DOMAIN is set.
#! 4. If MPI tasks perform better when sharing caches/sockets, try I_MPI_PIN_ORDER=compact.

cat $0

export IMBDIR="/home/hpcturn1/rds/hpc-work/benchmarks/mpi-benchmarks"

nodes=4
cpn=32
tests="PingPong Sendrecv Allgather Alltoall Allgatherv Alltoallv"
mpilib="IMPI193"

timestamp=$(date '+%Y%m%d%H%M')
cores=$(( nodes * cpn ))

for test in $tests
do
   mpirun -n $cores -ppn ${cpn} ${IMBDIR}/IMB-MPI1 -mem 1.4 -npmin ${cores} ${test} > IMB_${test}_${nodes}nodes_${mpilib}_${timestamp}.out
done



