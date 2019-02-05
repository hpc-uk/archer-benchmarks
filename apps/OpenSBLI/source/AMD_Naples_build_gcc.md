# AMD Naples (EPYC) OpenSBLI benchmark build instructions

## Build prerequisites

zlib:

```bash
./configure —prefix=/scratch_lustre_DDN7k/xguox/zlib/install
make
make install
export LD_LIBRARY_PATH=/scratch_lustre_DDN7k/xguox/zlib/install/lib:$LD_LIBRARY_PATH
```

hdf5 (parallel enabled):

```bash
CC=/opt/amd/openmpi/2.1.1-gcc7.2.0/bin/mpicc ./configure --enable-parallel --prefix=/scratch_lustre_DDN7k/xguox/hdf5/hdf5-1.10.2-gnu-install
make
make install
export PATH=/scratch_lustre_DDN7k/xguox/hdf5/hdf5-1.10.2-gnu-install/bin:$PATH
export LD_LIBRARY_PATH=/scratch_lustre_DDN7k/xguox/hdf5/hdf5-1.10.2-gnu-install/lib:$LD_LIBRARY_PATH
```

## Build OPS

```bash
cd OPS/ops/c
```

Load the required modules:

```bash
module use /opt/amd/modulefiles/AMD/
module load gcc/7.2.0
module load OpenMPI/2.1.1-gcc7.2.0 
module load OpenBLAS/0.2.20/gcc/4.8.5/threads
```

Set the required environment variables:

```bash
export OPS_COMPILER=gnu
export OPS_INSTALL_PATH=/scratch_lustre_DDN7k/xguox/opensbli/OPS/ops
export MPI_INSTALL_PATH=/opt/amd/openmpi/2.1.1-gcc7.2.0
export HDF5_INSTALL_PATH=/scratch_lustre_DDN7k/xguox/hdf5/hdf5-1.10.2-gnu-install
```

Build the OPS library:

```bash
make clean
make mpi
export LD_LIBRARY_PATH=/scratch_lustre_DDN7k/xguox/opensbli/OPS/ops/c/lib:$LD_LIBRARY_PATH
```

## Build the OpenSBLI benchmark

Note:
In OpenSBLI_ops.cpp, `HDF5op[4]` was changed to `HDF5op[6]` in `int main()`.
The original `HDF5op[4]` required insufficient space for the string “True” or “False” from the input file and will cause run time error during the reading operation.

```bash
cd ../../../Benchmark
make clean
make OpenSBLI_mpi
```

