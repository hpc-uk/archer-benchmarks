#!/bin/bash -l

#$ -pe mpi 36
#$ -l h_rt=3:00:00
#$ -l mem=4G
#$ -cwd

#$ -t 1-10

#####################################################################
# Modules needed for the run
#####################################################################
module load rcps-core
module load compilers/intel/2017/update4 
module load mpi/intel/2017/update3/intel 

module load castep/intel-2017-owain
#module load castep/17.21/intel-2017

#####################################################################
# Set the benchmark run parameters
#####################################################################
#
#  nodes: Total number of compute nodes to use
#  sockets: Processor sockets per compute node
#  cpersocket: Number of cores per socket
#  smt: Number of hardware threads to use per core
#  threads: Number of OpenMP threads to use per MPI process (must be a factor of cpersocket * smt)
#  castep_exe_cmd: Command for CASTEP
#
nodes=1
casename="al3x3"
timestamp=$(date '+%Y%m%d%H%M')
castep_exe_cmd='castep.mpi'
benchmark_file='/home/uccaoke/Source/archer-benchmarks/apps/CASTEP/al3x3.tgz'
#####################################################################
# Move to working directory, copy input and launch job
#####################################################################
if [ ! -d "results_${nodes}nodes_${timestamp}" ]
then 
   mkdir results_${nodes}nodes_${timestamp}_${JOB_ID}_${SGE_TASK_ID} 
fi
cd results_${nodes}nodes_${timestamp}_${JOB_ID}_${SGE_TASK_ID}
tar zxvf ${benchmark_file}
cd Al2O3-slab/3x3

#####################################################################
# Set the parallel launch command
#####################################################################
parrun="gerun "
echo "Parallel launch command:"
echo "${parrun} ${castep_exe_cmd} ${casename}"

#####################################################################
# Run the benchmark
#####################################################################
${parrun} ${castep_exe_cmd} ${casename}

