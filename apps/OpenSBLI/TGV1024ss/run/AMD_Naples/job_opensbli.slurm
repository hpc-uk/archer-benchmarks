#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --ntasks-per-node=16
#SBATCH -J opensbli_1node_16tasks
#SBATCH -p EPYC-16c_edr-ib1_256gb_2666
#SBATCH --time=01:00:00
#SBATCH --exclusive

#! Number of nodes and tasks per node allocated by SLURM (do not change):
numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')

#! Full path to application executable: 
application="/scratch_lustre_DDN7k/xguox/opensbli/Benchmark/OpenSBLI_mpi"

#! Run options for the application:
options=""

#! Work directory (i.e. where the job will run):
workdir="$SLURM_SUBMIT_DIR" 

#! Number of MPI tasks to be started by the application per node and in total (do not change):
np=$[${numnodes}*${mpi_tasks_per_node}]

#! OpenMP threads number
export OMP_NUM_THREADS=1

#! Command run
CMD="srun -n $np $application $options"

#! run the code
cd $workdir

JOBID=$SLURM_JOB_ID

echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Current directory: `pwd`"

echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"

echo -e "\nExecuting command:\n==================\n$CMD\n"

timestamp=$(date '+%Y%m%d%H%M')
srun -n $np $application $options> output_${numnodes}nodes_${timestamp}.txt 2> stderr.txt


