#!/bin/bash --login
#SBATCH --time=3:0:0
#SBATCH --job-name=GromacsBench
#SBATCH --partition=compute
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=28
#SBATCH --account=a01

cat $0

MPI_LAUNCH=mpirun

NUM_NODES=2

BENCHDIR=/gpfs/home/lboro/auser/benchmarks/ARCHER/GROMACS/GromacsARCHERBench_master

module load gromacs/2016.3

MDRUN="mdrun_mpi"

casename=nc2-cubic-md
timestamp=$(date '+%Y%m%d%H%M')

INPUTDIR=$BENCHDIR/run
TPRFILE=nsteps800.tpr

WORKDIR=/gpfs/home/lboro/auser/benchmarks/ARCHER/GROMACS/gromacs_scratch

#hardware specific settings
CHIPS_PER_NODE=2
CORES_PER_CHIP=14

#choose number of MPI tasks per chip
TASKS_PER_CHIP=14

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
${MPI_LAUNCH} -n $tasks -ppn  $[$CHIPS_PER_NODE*$TASKS_PER_CHIP] $MDRUN -s $TPRFILE -deffnm $casename -ntomp $OMP_NUM_THREADS -noconfout
date

echo
echo $casename.log
echo "------------"

resultsfile="${casename}_${NUM_NODES}nodes_${timestamp}.log"
mv $casename.log ${BENCHDIR}/run/${resultsfile}


