#!/bin/bash
#SBATCH --time=2:0:0
#SBATCH --job-name=IMB
#SBATCH --partition=compute
#SBATCH --nodes=16
#SBATCH --ntasks-per-node=28
#SBATCH --account=a17-benchmarking

module load gcc/6.3.0/1
module load intel/compiler/64/2018.2.199
module load intel/mpi/64/2018.2.199  

export IMBDIR="/gpfs/home/misc/artbench/benchmarks/mpi-benchmarks"

nodes=16
cpn=28
tests="PingPong Sendrecv Allgather Alltoall Allgatherv Alltoallv"
mpilib="IMPI182"

timestamp=$(date '+%Y%m%d%H%M')
cores=$(( nodes * cpn ))

for test in $tests
do
   mpirun -n $cores -ppn ${cpn} ${IMBDIR}/IMB-MPI1 -mem 1.4 -npmin ${cores} ${test} > IMB_${test}_${nodes}nodes_${mpilib}_${timestamp}.out
done

