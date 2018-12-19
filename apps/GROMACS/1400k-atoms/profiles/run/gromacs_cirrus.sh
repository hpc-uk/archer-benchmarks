#!/bin/bash 

EXPECTED_ARGS=1
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` Please specify number of nodes to use"
  echo "Usage: `basename $0` Assume 1 OpenMP thread and all MPI procs per node used"
  exit $E_BADARGS
fi
echo "Generating script to run Gromacs 1400K atom benchmark on Cirrus with $1 nodes and 1 OpenMP thread"

cat <<EOF > gromacs_1400k_atom_${1}_nodes_cirrus.pbs
#!/bin/bash --login
#
#PBS -N GROMACS_1400k
#PBS -l select=$1:ncpus=36
#PBS -l walltime=01:00:00
#PBS -l place=scatter:excl
### Please note: using tds queue, this only works for people in the z04 project 
### If not in z04 or you need more than two nodes then then please comment out
### the "#PBS -q tds" line
#PBS -q tds
#PBS -A z04

nodes=$1

# Set up paths and make directories if they don't already exist
# TOPDIR = top level directory for all runs
# RUNDIR = directory for regular runs, e.g. scaling tests
# RUNDIRVTUNE = directory for the vtune runs, separate directory used so we can keep our scaling results
export TOPDIR=/lustre/home/z04/fiona/Projects/Profiling/Gromacs/1400k-atom-benchmark
cd \$TOPDIR
mkdir 1400k_atom_benchmark_\${nodes}_nodes
export RUNDIR=\$TOPDIR/1400k_atom_benchmark_\${nodes}_nodes
mkdir 1400k_atom_benchmark_\${nodes}_nodes_vtune
export RUNDIRVTUNE=\$TOPDIR/1400k_atom_benchmark_\${nodes}_nodes_vtune

# Load required modules
# Gromacs was built with gcc/6.3.0
# Use vtune version 2018, update 4 as that's the latest version installed
module load gcc/6.3.0 
module load mpt 
module load intel-vtune-18/2018.4.0.573462

# Use our own build of Gromacs 2018.3. To do this we need to set all the paths and 
# environment settings etc that the Gromacs module file would normally set. If you use 
# the centrally installed module you don't need the following 8 statements.
export mygmxpath=/lustre/home/z04/fiona/Projects/Profiling/gmx/gromacs-2018.3_gcc_6.3.0
export GMX_DIR=\$mygmxpath
export PATH=\$mygmxpath/bin:\$PATH
export MANPATH=\$mygmxpath/share/man
export PE_PRODUCT_LIST=\$PE_PRODUCT_LIST:\$mygmxpath/bin
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$mygmxpath/lib64
export GMX_INCLUDE_OPTS=\$mygmxpath/include
export GMXLIB=\$mygmxpath/share/gromacs/top

# Set up variables relating to benchmark run, casename is for full length 10000 time step run, 
# casename_short uses the 500 time step version for testing etc
casename="benchmark"
casename_short="benchmark_short"
cpn=36
mdrun="gmx_mpi mdrun"
cores=\$(( \$nodes * \$cpn ))
timestamp=\$(date '+%Y%m%d%H%M')
resfile="\${casename}_\${nodes}_nodes_\${timestamp}"
resfile_vtune="\${casename}_\${nodes}_nodes_\${timestamp}_vtune"

# Set number of threads 
export OMP_NUM_THREADS=1

# For full length, non profiling type uncomment the following 3 lines
###cd \$RUNDIR
###echo "Running GROMACS on \$cores cores with \$cpn cores per node - full 10000 time steps"
###mpiexec_mpt -n \${cores} -ppn \${cpn} \${mdrun} -s \${TOPDIR}/\${casename}.tpr -g \${resfile} -noconfout

# For VTune profiling runs use the following
cd \$RUNDIRVTUNE
echo "Profiling GROMACS using VTune on \$cores cores with \$cpn cores per node"
# Note: /tmp on the compute nodes is tiny (150Mb) and vtune uses this so we set 
# TMPDIR in our file space and add -target-tmp-dir to the amplxe-cl flags
# The location you set TMPDIR to must be somewhere you have write permission to
# -data-limit=0 should mean the profile can be any size, the default size is limited to 500Mb

export TMPDIR=/lustre/home/z04/fiona/tmp
# Tidy up any old files in your TMPDIR 
rm -rf \$TMPDIR/*
echo "TMPDIR =  \$TMPDIR"

# VTune profile test run with 500 time steps and no source paths added in
###mpiexec_mpt -n \${cores} -ppn \${cpn} amplxe-cl -data-limit=0 -target-tmp-dir=\$TMPDIR -collect hotspots gmx_mpi mdrun -s \${TOPDIR}/\${casename_short}_500.tpr -g \${resfile}_500step_tmp_no_symbols -noconfout
###sleep 30

# VTune profile test run with 500 time steps and source and library paths added in. 
# adding the paths in won't add source lines unless you've compiled with -g (harms performance on Gromacs)
# but the paths are included as an example here
###mpiexec_mpt -n \${cores} -ppn \${cpn} amplxe-cl -search-dir=/lustre/home/z04/fiona/Projects/Profiling/gmx/gromacs-2018.3_gcc_6.3.0/lib64 -search-dir=/lustre/home/z04/fiona/Projects/Profiling/gmx/gromacs-2018.3_gcc_6.3.0/bin -search-dir=/lustre/home/z04/fiona/Projects/Profiling/gromacs-2018.3/src/gromacs -search-dir=/usr/lib64 -search-dir=/lib64 -search-dir=/lustre/sw/gcc/6.3.0/lib64 -search-dir=/opt/hpe/hpc/mpt/mpt-2.16/lib -search-dir=/lustre/sw/intel/vtune_amplifier_2018.4.0.573462/lib64/pinruntime -search-dir=/lustre/sw/intel/vtune_amplifier_2018.4.0.573462/lib64 -data-limit=0 -target-tmp-dir=\$TMPDIR -collect hotspots gmx_mpi mdrun -s \${TOPDIR}/\${casename_short}_500.tpr -g \${resfile}_500step_tmp_with_symbols -noconfout
###sleep 30

# VTune profile, full 10000 time step run with source and library paths added (see above)
mpiexec_mpt -n \${cores} -ppn \${cpn} amplxe-cl -search-dir=/lustre/home/z04/fiona/Projects/Profiling/gmx/gromacs-2018.3_gcc_6.3.0/lib64 -search-dir=/lustre/home/z04/fiona/Projects/Profiling/gmx/gromacs-2018.3_gcc_6.3.0/bin -search-dir=/lustre/home/z04/fiona/Projects/Profiling/gromacs-2018.3/src/gromacs -search-dir=/usr/lib64 -search-dir=/lib64 -search-dir=/lustre/sw/gcc/6.3.0/lib64 -search-dir=/opt/hpe/hpc/mpt/mpt-2.16/lib -search-dir=/lustre/sw/intel/vtune_amplifier_2018.4.0.573462/lib64/pinruntime -search-dir=/lustre/sw/intel/vtune_amplifier_2018.4.0.573462/lib64 -data-limit=0 -target-tmp-dir=\$TMPDIR -collect hotspots gmx_mpi mdrun -s \${TOPDIR}/\${casename}.tpr -g \${resfile}_full_tmp -noconfout
sleep 300  


# Tidy up after run completes
rm ener.edr

EOF

qsub gromacs_1400k_atom_${1}_nodes_cirrus.pbs
