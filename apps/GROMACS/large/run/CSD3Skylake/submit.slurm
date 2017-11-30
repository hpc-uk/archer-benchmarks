#!/bin/bash
#SBATCH -J gmx_bench
#SBATCH -A T2BENCH-SL2-CPU
#SBATCH --nodes=16
#SBATCH --ntasks=512
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
module load rhel7/default-peta4                   # REQUIRED - loads the basic environment
module load gcc-7.2.0-gcc-4.8.5-pqn7o2k

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

MPI_LAUNCH=mpirun

NUM_NODES=${numnodes}

BENCHDIR=/home/hpcturn1/rds/hpc-work/benchmarks/ARCHER/GROMACS/ARCHER_large/GromacsARCHERBench_master

MDRUN="/home/hpcturn1/software/gromacs-2016.4/build_mpi1/bin/mdrun_mpi"

casename=nc2-cubic-md
timestamp=$(date '+%Y%m%d%H%M')

INPUTDIR=$BENCHDIR/inputTPR
TPRFILE=nsteps800.tpr

WORKDIR=/home/hpcturn1/rds/hpc-work/benchmarks/ARCHER/GROMACS/ARCHER_large/gromacs_scratch

#hardware specific settings
CHIPS_PER_NODE=2
CORES_PER_CHIP=16

#choose number of MPI tasks per chip
TASKS_PER_CHIP=16

#choose number of hyperthreads per core
HTHREADS_PER_CORE=1 

#number of OpenMP threads per task is calculated 
export OMP_NUM_THREADS=$[($CORES_PER_CHIP*$HTHREADS_PER_CORE)/$TASKS_PER_CHIP]

#total number of tasks is calculated
tasks=$[$NUM_NODES*$CHIPS_PER_NODE*$TASKS_PER_CHIP]

rm -rf $WORKDIR
mkdir -p $WORKDIR
cd $WORKDIR

cp $INPUTDIR/$TPRFILE .

date
${MPI_LAUNCH} -n $tasks -ppn  $[$CHIPS_PER_NODE*$TASKS_PER_CHIP] $MDRUN -s $TPRFILE -deffnm $casename -ntomp $OMP_NUM_THREADS
date

echo
echo $casename.log
echo "------------"

resultsfile="${casename}_${NUM_NODES}nodes_${timestamp}.log"
mv $casename.log ${BENCHDIR}/run/${resultsfile}


