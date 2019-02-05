#!/bin/bash
#SBATCH -J gmx_1400atoms_1node_16tasks
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --ntasks-per-node=16
#SBATCH --time=12:0:0
#SBATCH -p EPYC-16c_edr-ib1_256gb_2666
#SBATCH --exclusive


export PATH=/scratch_lustre_DDN7k/xguox/python/install-gnu7.2.0/bin:$PATH
export LD_LIBRARY_PATH=/scratch_lustre_DDN7k/xguox/python/install-gnu7.2.0/lib:$LD_LIBRARY_PATH
export PATH=/scratch_lustre_DDN7k/xguox/fftw/install-gnu7.2.0/bin:$PATH
export LD_LIBRARY_PATH=/scratch_lustre_DDN7k/xguox/fftw/install-gnu7.2.0/lib:$LD_LIBRARY_PATH
export PATH=/scratch_lustre_DDN7k/xguox/fftw/install-gnu7.2.0-single/bin:$PATH
export LD_LIBRARY_PATH=/scratch_lustre_DDN7k/xguox/fftw/install-gnu7.2.0-single/lib:$LD_LIBRARY_PATH
export PATH=/scratch_lustre_DDN7k/xguox/gromacs/install/bin:$PATH

echo "PATH="
echo $PATH

#! Work directory (i.e. where the job will run):
cd $SLURM_SUBMIT_DIR

#! Are you using OpenMP (NB this is unrelated to OpenMPI)? If so increase this
#! safe value to no more than 16:
export OMP_NUM_THREADS=1

nodes=$SLURM_JOB_NUM_NODES
casename="benchmark"
# steps=100000

cpn=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
mdrun="/scratch_lustre_DDN7k/xguox/gromacs/install/bin/mdrun_mpi"

cores=$(( nodes * cpn ))
timestamp=$(date '+%Y%m%d%H%M')
resfile="${casename}_${nodes}nodes_${timestamp}"


srun -n ${cores} ${mdrun} -s ${casename}.tpr -g ${resfile} -noconfout

rm ener.edr
