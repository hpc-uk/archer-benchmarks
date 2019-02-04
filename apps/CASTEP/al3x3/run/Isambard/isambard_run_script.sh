#!/bin/bash
#
# Note: no batch system on Isambard Phase 1

#####################################################################
# Modules needed for the run
#####################################################################

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
sockets=2
cpersocket=32
smt=1
threads=1
castep_exe_cmd='castep.mpi'

#####################################################################
# Other variables (should not need to be changed)
#####################################################################
casename="al3x3"
timestamp=$(date '+%Y%m%d%H%M')
lcpersocket=$(( cpersocket * smt ))
rankpersocket=$(( lcpersocket / threads ))
rankpernode=$(( rankpersocket * sockets ))
totrank=$(( rankpernode * nodes ))

#####################################################################
# Move to working directory, copy input and launch job
#####################################################################
if [ ! -d "results_${nodes}nodes_${timestamp}" ]
then 
   mkdir results_${nodes}nodes_${timestamp}
fi
cd results_${nodes}nodes_${timestamp}
cp ../input/* .
export OMP_NUM_THREADS=${threads}

#####################################################################
# Set the parallel launch command
#####################################################################
parrun="mpiexec -n ${totrank} -ppn ${rankpernode}"
echo "Parallel launch command:"
echo "${parrun} ${castep_exe_cmd} ${casename}"

#####################################################################
# Run the benchmark
#####################################################################
${parrun} ${castep_exe_cmd} ${casename}

