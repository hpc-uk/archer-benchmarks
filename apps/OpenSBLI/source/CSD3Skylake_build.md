# CSD3-Skylake OpenSBLI benchmark build instructions

## Build OPS

```bash
cd OPS/ops/c
```

Load the required modules:

```bash
module load hdf5-1.10.1-intel-17.0.4-acprvzg
```

Set the required environment variables:

```bash
export MPICC_CC=icc
export MPICXX_CXX=icpc
export OPS_COMPILER=intel
export OPS_INSTALL_PATH=/home/user/benchmark/archer-benchmarks/apps/OpenSBLI/source/OPS/ops
export MPI_INSTALL_PATH=/usr/local/Cluster-Apps/intel/2017.4/compilers_and_libraries_2017.4.196/linux/mpi/intel64
export HDF5_INSTALL_PATH=/usr/local/software/spack/develop-290617/spack/opt/spack/linux-rhel7-x86_64/intel-17.0.4/hdf5-1.10.1-acprvzgvcp5qo33z4qpfaod5yg4skbwl
```

Build the OPS library:

```bash
make clean
make mpi
```

## Build the OpenSBLI benchmark

```bash
cd ../../../Benchmark
make clean
make OpenSBLI_mpi
```

