# AMD Naples (EPYC) OpenSBLI benchmark build instructions: Intel 17 compilers

Load the required modules:

```bash
module use /opt/amd/modulefiles/AMD/
module load gcc/7.2.0
export PATH=/opt/intel/compilers_and_libraries_2017.7.259/linux/bin/intel64:$PATH
export LD_LIBRARY_PATH=/opt/intel/compilers_and_libraries_2017.7.259/linux/lib/intel64:/opt/intel/compilers_and_libraries_2017.7.259/linux/compiler/lib/intel64_lin:$LD_LIBRARY_PATH
 . /opt/intel/compilers_and_libraries_2017.7.259/linux/mpi/intel64/bin/mpivars.sh
```

## Build prerequisites

zlib:

```bash
export CC=/opt/intel/compilers_and_libraries_2017.7.259/linux/bin/intel64/icc
export CFLAGS='-O3 -xHost -ip'

./configure —prefix=/scratch_lustre_DDN7k/xguox/zlib/install-intel2017
make
make check
make install

export LD_LIBRARY_PATH=/scratch_lustre_DDN7k/xguox/zlib/install-intel2017/lib:$LD_LIBRARY_PATH
```

hdf5 (parallel enabled):

```bash
export CC=/opt/intel/compilers_and_libraries_2017.7.259/linux/mpi/intel64/bin/mpiicc
export CXX=/opt/intel/compilers_and_libraries_2017.7.259/linux/mpi/intel64/bin/mpiicpc
export FC=/opt/intel/compilers_and_libraries_2017.7.259/linux/mpi/intel64/bin/mpiifort

./configure --enable-parallel --prefix=/scratch_lustre_DDN7k/xguox/hdf5/hdf5-1.10.2-intel2017-install --enable-fortran --enable-cxx --enable-unsupported
export PATH=/scratch_lustre_DDN7k/xguox/hdf5/hdf5-1.10.2-intel2017-install/bin:$PATH
export LD_LIBRARY_PATH=/scratch_lustre_DDN7k/xguox/hdf5/hdf5-1.10.2-intel2017-install/lib:$LD_LIBRARY_PATH
```

## Build OPS

```bash
cd OPS/ops/c
```

Set the required environment variables:

```bash
export OPS_COMPILER=intel
export OPS_INSTALL_PATH=/scratch_lustre_DDN7k/xguox/opensbli/OPS/ops
export MPI_INSTALL_PATH=/opt/intel/compilers_and_libraries_2017.7.259/linux/mpi/intel64
export HDF5_INSTALL_PATH=/scratch_lustre_DDN7k/xguox/hdf5/hdf5-1.10.2-intel2017-install
mpicc=mpiicc
mpiCC=mpiicpc
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

