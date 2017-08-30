# HPCC Build: Cirrus

Setup environment, swap to GCC:

```bash
module load intel-mpi-17
module load gcc/6.3.0
module load intel-cmkl-17
```

Copy Make.cirrus_gcc into hpl/ directory

Build:

```bash
make arch=cirrus_gcc
```

