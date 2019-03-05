# CSD3-Skylake OpenSBLI benchmark build instructions

## Build OPS

```bash
cd OPS/ops/c
```

Load the required modules:

```bash
module purge
module load rhel7/global 
module load intel/bundles/complib/2019.3
module load hdf5-1.10.1-intel-17.0.4-acprvzg
```

Set the required environment variables:

```bash
export MPICC_CC=icc
export MPICXX_CXX=icpc
export OPS_COMPILER=intel
export OPS_INSTALL_PATH=/home/user/benchmark/archer-benchmarks/apps/OpenSBLI/source/OPS/ops
export MPI_INSTALL_PATH=/usr/local/Cluster-Apps/intel/2019.3//compilers_and_libraries_2019.3.192/linux/mpi/intel64
export HDF5_INSTALL_PATH=/usr/local/software/spack/develop-290617/spack/opt/spack/linux-rhel7-x86_64/intel-17.0.4/hdf5-1.10.1-acprvzgvcp5qo33z4qpfaod5yg4skbwl
```

Modify the Makefile so that the compile lines for the "intel" environment are:

```
ifeq ($(OPS_COMPILER),intel)
  CC            := icc -std=c99
ifdef DEBUG
  CCFLAGS       := -O0 -g
else
  CCFLAGS       := -O3 -xHOST
endif
  CXX           := icpc
  CXXFLAGS      := $(CCFLAGS)
  MPICC         := $(MPI_INSTALL_PATH)/bin/mpicc -std=c99
  MPICXX        := $(MPI_INSTALL_PATH)/bin/mpicxx
  MPIFLAGS      := $(CXXFLAGS) -DMPICH_IGNORE_CXX_SEEK -DMPICH_SKIP_MPICXX
```

Build the OPS library:

```bash
make clean
make mpi
```

## Build the OpenSBLI benchmark

Move to the right directory:

```bash
cd ../../../Benchmark
```

Modify the Makefile so that the compile lines for the "intel" environment are:

```
ifeq ($(OPS_COMPILER),intel)
  CPP   = icpc
ifdef DEBUG
  CCFLAGS = -O0 -g -no-prec-div $(HDF5_LIB) -openmp -prec-div -prec-sqrt -DMPICH_IGNORE_CXX_SEEK
else
  CCFLAGS = -O3 -xHOST -ipo -no-prec-div -restrict -fno-alias -DMPICH_IGNORE_CXX_SEEK
endif
  CPPFLAGS  = $(CCFLAGS)
  OMPFLAGS  = $(HDF5_LIB) -openmp $(HDF5_LIB) -openmp-report2
  MPICPP  = $(MPI_INSTALL_PATH)/bin/mpicxx
  MPIFLAGS  = $(CCFLAGS)
```

Build the benchmark:

```bash
cd ../../../Benchmark
make clean
make OpenSBLI_mpi
```

