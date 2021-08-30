# Hawk (HLRS) OpenSBLI benchmark build instructions

## Build OPS

```bash
cd OPS/ops/c
```

Load the required modules:

```bash
module load hdf5
```

Both `gcc/9.2.0` and `mpt/2.23` should be loaded by default.

Set the required environment variables:

```bash
export OPS_COMPILER=gnu
export OPS_INSTALL_PATH=/lustre/hpe/ws10/ws10.3/ws/dir/benchmarks/OpenSBLI/source/OPS/ops
export MPI_INSTALL_PATH=/opt/hpe/hpc/mpt/mpt-2.23
export HDF5_INSTALL_PATH=/opt/hlrs/spack/rev-004_2020-06-17/hdf5/1.10.5-gcc-9.2.0-fsds2dq4
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
make OpenSBLI_mpi_openmp
```

