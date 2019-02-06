#!/bin/bash
#SBATCH --nodes=8
#SBATCH --ntasks=128
#SBATCH --ntasks-per-node=16
#SBATCH -J castep_a13x3_8nodes
#SBATCH -p EPYC-16c_edr-ib1_256gb_2666
#SBATCH --time=02:30:00
#SBATCH --exclusive

export CASTEP_EXE=/scratch_lustre_DDN7k/xguox/castep/CASTEP-18.1-install/castep.mpi
srun -n 128 $CASTEP_EXE al3x3 
