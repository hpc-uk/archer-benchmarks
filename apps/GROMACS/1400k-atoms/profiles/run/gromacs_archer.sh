#!/bin/bash 

EXPECTED_ARGS=1
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` Please specify number of nodes to use"
  echo "Usage: `basename $0` Assume 1 OpenMP thread and all MPI procs per node used"
  exit $E_BADARGS
fi
echo "Generating script to run Gromacs 1400K atom benchmark on ARCHER with $1 nodes and 1 OpenMP thread"

cat <<EOF > gromacs_1400k_atom_${1}_nodes_archer.pbs
#!/bin/bash --login
#
#PBS -N GROMACS_1400k
#PBS -l select=$1
#PBS -l walltime=1:00:00
#PBS -A z19-csetds

nodes=$1

export TOPDIR=/work/z01/z01/fiona/Profiling/Gromacs/1400k-atom-benchmark
cd \$TOPDIR
mkdir 1400k_atom_benchmark_\${nodes}_nodes
export RUNDIR=\$TOPDIR/1400k_atom_benchmark_\${nodes}_nodes
cd \$RUNDIR

# Use 2018.2 module build with data copied to /work as a test
###module load gromacs/2018.2
###export mygmxpath=/work/z01/z01/fiona/Profiling/Gromacs/gromacs-2018.2
###description="2018.2"
# Use my build of 2018.3: 
###export mygmxpath=/work/z01/z01/fiona/Profiling/Gromacs/gmx/gromacs-2018.3_gcc_6.3.0
###description="2018.3"
# Use my build of 2018.3 with Craypat Instrumentation added in: 
export mygmxpath=/work/z01/z01/fiona/Profiling/Gromacs/gmx/gromacs-2018.3_gcc_6.3.0_craypat
description="2018.3_craypat"

# Everything in this section should be left unchanged
export GMX_DIR=\$mygmxpath
export PATH=\$mygmxpath/bin:\$PATH
export PE_PRODUCT_LIST=\$PE_PRODUCT_LIST:\$mygmxpath/bin
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$mygmxpath/lib64
export GMX_INCLUDE_OPTS=\$mygmxpath/include
export GMXLIB=\$mygmxpath/share/gromacs/top

# Set up benchmark name, run parameters etc
casename="benchmark"
cpn=24
cores=\$(( \$nodes * \$cpn ))
timestamp=\$(date '+%Y%m%d%H%M')
resfile="\${casename}_\${nodes}_nodes_\${timestamp}_\${description}"

# Select Gromacs binary to run depending on whether we're running an instrumented 
# build or not. The description variable above controls this
if [[ \${description} == *"_craypat"* ]]
then 
   mdrun="mdrun_mpi+samp"
else
   mdrun="mdrun_mpi"
fi
echo "The particular mdrun that will be used for this run is \${mdrun}"


# Set number of OpenMP threads to 1
export OMP_NUM_THREADS=1
aprun -n \${cores} -N \${cpn} \${mdrun} -s \${TOPDIR}/\${casename}.tpr -g \${resfile} -noconfout

# Tidy up after run completes
rm ener.edr

EOF

qsub gromacs_1400k_atom_${1}_nodes_archer.pbs
