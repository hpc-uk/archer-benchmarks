#!/bin/bash
#SBATCH --job-name=CdTe
#SBATCH --time=3:0:0
#SBATCH --nodes=4
#SBATCH --tasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --exclusive
#SBATCH --account=z19

module load epcc-job-env
module load vasp/5

VASP_EXE="vasp_ncl"

nodes=$SLURM_JOB_NUM_NODES
casename="CdTe"
ncore=8
kpar=2
cpn=128
threads=1

cp INCAR.base INCAR
echo "NCORE=${ncore}" >> INCAR
echo "KPAR=${kpar}" >> INCAR

cores=$(( nodes * cpn ))
timestamp=$(date '+%Y%m%d%H%M')
resfile="${casename}_${nodes}nodes_${cores}cores_${threads}threads_${ncore}NCORE_${kpar}KPAR_${timestamp}.OUTCAR"
TMPDIR=$PWD

export OMP_NUM_THREADS=${threads}
rm WAVECAR
srun --cpu-bind=cores $VASP_EXE
sleep 30

mv OUTCAR ${resfile}


