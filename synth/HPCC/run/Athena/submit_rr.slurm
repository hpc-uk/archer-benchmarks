#!/bin/bash
#
#SBATCH --time=1:0:0
#SBATCH --job-name=hpcc_test
#SBATCH --partition=compute
#SBATCH --nodes=16
#SBATCH --ntasks-per-node=28
#SBATCH --account=a01

module load gcc/6.3.0/1
module load intel/mpi/64/2017.2.174
module load intel/runtime/64/2016.3.210 
module load intel/mkl/64/2017.2.174

mpilaunch=mpirun
corespn=28

nodeslist="16 8 4 2"

for nodes in $nodeslist
do
   cores=$(( nodes * corespn ))
   if [ -f hpccoutf.txt ] 
   then 
      rm hpccoutf.txt
   fi

   timestamp=$(date '+%Y%m%d%H%M')
   ${mpilaunch} -n ${nodes} -ppn 1 ./hpcc
   mv hpccoutf.txt nodes${nodes}ppn1_${timestamp}_hpccoutf.txt
   ${mpilaunch} -n ${cores} -ppn ${corespn} ./hpcc
   mv hpccoutf.txt nodes${nodes}ppn${corespn}_${timestamp}_hpccoutf.txt
done

