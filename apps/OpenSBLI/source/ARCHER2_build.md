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
Clang section of the `Makefile` to the Cray section. The MPI C compiler
should still be `cc` and the MPI C++ compiler `CC`. The Cray section in
`Makefile` should look like:

```
ifeq ($(OPS_COMPILER),cray) # CCE 10, based on Clang
  CC        := cc
  CUDA_ALIGNE_FLAG := -D__x86_64 -D__align__\(n\)=__attribute__\(\(aligned\(n\)\)\) -D__location__\(a\)=__annotate__\(a\) -DCUDARTAPI=
  CCFLAGS   := -O3 -std=c99 -fPIC -DUNIX -Wall -ffloat-store
  CXX       := CC
  CXXFLAGS  := -fPIC -DUNIX -Wall
  MPICXX    := CC
  MPICC     := cc
  MPIFLAGS  := $(CXXFLAGS)
else
```

Build the OPS library:

```bash
make clean
make mpi
```

## Build the OpenSBLI benchmark

Move to the benchmark directory:

```bash
cd ../../../Benchmark
```

As the Cray C/C++ compiler is now Clang-based, move the options from the
Clang section of the `Makefile` to the Cray section. The MPI C compiler
should still be `cc` and the MPI C++ compiler `CC`. The Cray section in
`Makefile` should look like:

```
ifeq ($(OPS_COMPILER),cray)
  CPP       = CC
    CUDA_ALIGN_FLAG := -D__x86_64 -D__align__\(n\)=__attribute__\(\(aligned\(n\)\)\) -D__location__\(a\)=__annotate__\(a\) -DCUDARTAPI=
ifdef DEBUG
  CCFLAGS   = -O2
else
  CCFLAGS   = -O3 -fPIC -DUNIX -Wall
endif
  CPPFLAGS  = $(CCFLAGS)
  OMPFLAGS  = -fopenmp
  MPICPP    = CC
  MPICC     = cc
  MPIFLAGS  = $(CPPFLAGS)
else
```

Once this is all setup, you can compile the benchmark with:

```bash
make clean
make OpenSBLI_mpi
```

