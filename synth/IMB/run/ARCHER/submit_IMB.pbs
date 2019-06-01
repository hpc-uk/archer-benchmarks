#!/bin/bash --login
#
#PBS -N IMB
#PBS -l select=1
#PBS -l walltime=1:0:0
#PBS -A z19-cse

cd $PBS_O_WORKDIR

module swap PrgEnv-cray PrgEnv-intel

export IMBDIR="/work/z01/z01/aturner/benchmark/imb/mpi-benchmarks"

nodes=1
cpn=24
tests="PingPong Sendrecv Allgather Alltoall Allgatherv Alltoallv"
mpilib="CrayMPICH"

timestamp=$(date '+%Y%m%d%H%M')
cores=$(( nodes * cpn ))

for test in $tests
do
   aprun -n $cores ${IMBDIR}/IMB-MPI1 -mem 1.4 -npmin ${cores} ${test} > IMB_${test}_${nodes}nodes_${mpilib}_${timestamp}.out
done

