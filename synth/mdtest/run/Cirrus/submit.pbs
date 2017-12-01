#!/bin/bash --login
#
#PBS -N mdtest
#PBS -l select=2:ncpus=72
#PBS -l place=excl
#PBS -l walltime=3:0:0
#PBS -A t01

cd $PBS_O_WORKDIR

module load intel-compilers-17
module load mpt/2.14

nodes=2
nfile=1048576

mdtest="/lustre/home/t01/auser/benchmark/ior/src/mdtest"
testdir="/lustre/home/t01/auser/benchmark/ARCHER/mdtest/tmpdir"

cpn=36

if [ ! -d $tmpdir ]
then
  mkdir -p $tmpdir
fi

cores=$(( nodes * cpn ))
filespercore=$(( nfile / cores ))

timestamp=$(date '+%Y%m%d%H%M')
if [ $nodes -lt 2 ]
then
  mpiexec_mpt -n 1 -ppn 1 $mdtest -n ${filespercore} -F -C -T -r -N 1 -d ${testdir} > mdtest_mp-mf-sd_${nfile}_${nodes}nodes_${timestamp}.log
  rm -r $testdir
fi
mpiexec_mpt -n $cores -ppn $cpn $mdtest -n ${filespercore} -F -C -T -r -N $cpn -d ${testdir} > mdtest_mp-mf-sd_${nfile}_${nodes}nodes_${timestamp}.log
rm -r $testdir
mpiexec_mpt -n $cores -ppn $cpn $mdtest -n ${filespercore} -u -F -C -T -r -N $cpn -d ${testdir} > mdtest_mp-mf-md_${nfile}_${nodes}nodes_${timestamp}.log
rm -r $testdir
mpiexec_mpt -n $cores -ppn $cpn $mdtest -n 1 -S -F -C -T -r -d ${testdir} > mdtest_mp-sf-sd_${nfile}_${nodes}nodes_${timestamp}.log
rm -r $testdir
