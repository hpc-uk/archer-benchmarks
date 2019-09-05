# Thomas (MMMHub) OpenSBLI benchmark build instructions

## Build OPS

```bash
cd OPS/ops/c
```

Load the required modules:

```bash
module load hdf/5-1.8.15-p1-impi/intel-2015-update2
```

Set the required environment variables:

```bash
export MPICC_CC=icc
export MPICXX_CXX=icpc
export OPS_COMPILER=intel
export OPS_INSTALL_PATH=/home/user/benchmarks/ARCHER_apps/OpenSBLI/OPS/ops
export MPI_INSTALL_PATH=/shared/ucl/apps/intel/2017.Update1/impi/2017.1.132/intel64
export HDF5_INSTALL_PATH=/shared/ucl/apps/hdf5/1.8.15-p1-impi/intel-2015-update2
```

Build the OPS library:

```bash
make -f Makefile.ucl clean
make -f Makefile.ucl mpi
```

## Build the OpenSBLI benchmark

```bash
cd ../../../Benchmark
make -f Makefile.ucl clean
make -f Makefile.ucl OpenSBLI_mpi
```

