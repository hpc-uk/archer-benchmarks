# Isambard OpenSBLI benchmark build instructions

## Build HDF5 parallel

Download and build HDF5 parallel on Isambard following the instructions at:

- [Isambard HDF5 parallel build instructions](https://github.com/hpc-uk/build-instructions/blob/master/HDF5/build_hdf5_1102_gw4_cray.md)

You will need the install path for the step below.

## Build OPS

```bash
cd OPS/ops/c
```

```bash
export OPS_COMPILER=cray
export OPS_INSTALL_PATH=/home/brx-auser/software/OpenSBLI/OPS/ops
export MPI_INSTALL_PATH=
export HDF5_INSTALL_PATH=/home/brx-auser/software/hdf5/1.10.2-cray
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

