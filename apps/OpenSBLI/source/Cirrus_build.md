# Cirrus OpenSBLI benchmark build instructions

## Build OPS

```bash
cd OPS/ops/c
```

Load the required modules:

```bash
module load intel-compilers-17
module load mpt
module load hdf5parallel/1.10.1-intel17-mpt214
```

Set the required environment variables:

```bash
export MPICC_CC=icc
export MPICXX_CXX=icpc
export OPS_COMPILER=intel
export OPS_INSTALL_PATH=/lustre/home/z04/aturner/benchmark/ARCHER/OpenSBLI/OPS/ops
export MPI_INSTALL_PATH=/opt/sgi/mpt/mpt-2.14
export HDF5_INSTALL_PATH=/lustre/sw/hdf5parallel/1.10.1-intel17-mpt214
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

