# ARCHER OpenSBLI benchmark build instructions

## Build OPS

```bash
cd OPS/ops/c
```

Load the required modules:

```bash
module swap cray-mpich cray-mpich/7.5.2
module load cray-hdf5-parallel/1.10.0.1
```

Set the required environment variables:

```bash
export OPS_COMPILER=cray
export OPS_INSTALL_PATH=/work/t01/t01/user/benchmark/ARCHER/OpenSBLI/OPS/ops
export MPI_INSTALL_PATH=
export HDF5_INSTALL_PATH=
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

