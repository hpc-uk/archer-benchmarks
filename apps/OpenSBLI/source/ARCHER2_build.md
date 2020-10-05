# ARCHER OpenSBLI benchmark build instructions

## Build OPS

```bash
cd OPS/ops/c
```

Load the required modules:

```bash
module restore PrgEnv-cray
module load cray-hdf5-parallel
```

Set the required environment variables:

```bash
export OPS_COMPILER=cray
export OPS_INSTALL_PATH=/work/t01/t01/user/benchmark/ARCHER/OpenSBLI/OPS/ops
export MPI_INSTALL_PATH=
export HDF5_INSTALL_PATH=
```

As the Cray C/C++ compiler is now Clang-based, move the options from the
Clang section of the makefile to the Cray section. The MPI C compiler
should still be `cc` and the MPI C++ compiler `CC`.

Build the OPS library:

```bash
make clean
make mpi
```

## Build the OpenSBLI benchmark

As the Cray C/C++ compiler is now Clang-based, move the options from the
Clang section of the makefile to the Cray section. The MPI C compiler
should still be `cc` and the MPI C++ compiler `CC`.

```bash
cd ../../../Benchmark
make clean
make OpenSBLI_mpi
```

