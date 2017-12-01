#!/bin/bash
#SBATCH -J mdtest
#SBATCH -A TEST
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=0:20:0
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
module load rhel7/default-peta4                   # REQUIRED - loads the basic environment

#! Full path to application executable: 
application="/home/auser/software/ior/src"

#! Run options for the application:
options=""

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


#! Uncomment one choice for CMD below (add mpirun/mpiexec options if necessary):

#! Choose this for a MPI code (possibly using OpenMP) using Intel MPI.
CMD="mpirun -ppn $mpi_tasks_per_node -np $np $application $options"

#! Choose this for a pure shared-memory OpenMP parallel program on a single node:
#! (OMP_NUM_THREADS threads will be created):
#CMD="$application $options"

#! Choose this for a MPI code (possibly using OpenMP) using OpenMPI:
#CMD="mpirun -npernode $mpi_tasks_per_node -np $np $application $options"


###############################################################
### You should not have to change anything below this line ####
###############################################################

cd $workdir
echo -e "Changed directory to `pwd`.\n"

JOBID=$SLURM_JOB_ID

echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Running on master node: `hostname`"
echo "Current directory: `pwd`"

if [ "$SLURM_JOB_NODELIST" ]; then
        #! Create a machine file:
        export NODEFILE=`generate_pbs_nodefile`
        cat $NODEFILE | uniq > machine.file.$JOBID
        echo -e "\nNodes allocated:\n================"
        echo `cat machine.file.$JOBID | sed -e 's/\..*$//g'`
fi

echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"

echo -e "\nExecuting command:\n==================\n$CMD\n"

mdtest="/home/auser/software/ior/src/mdtest"
testdir="/home/auser/rds/hpc-work/benchmarks/ARCHER/mdtest/tmpdir"

nfile=1048576
cpn=32
cores=$(( numnodes * cpn ))
filespercore=$(( nfile / cores ))

timestamp=$(date '+%Y%m%d%H%M')
mpirun -ppn $mpi_tasks_per_node -np $np $mdtest -n ${filespercore} -F -C -T -r -N $cpn -d ${testdir} > mdtest_mp-mf-sd_${nfile}_${numnodes}nodes_${timestamp}.log
mpirun -ppn $mpi_tasks_per_node -np $np $mdtest -n ${filespercore} -u -F -C -T -r -N $cpn -d ${testdir} > mdtest_mp-mf-md_${nfile}_${numnodes}nodes_${timestamp}.log
rm -r $testdir
mpirun -ppn $mpi_tasks_per_node -np $np $mdtest -n 1 -S -F -C -T -r -d ${testdir} > mdtest_mp-sf-sd_${nfile}_${numnodes}nodes_${timestamp}.log
rm -r $testdir

