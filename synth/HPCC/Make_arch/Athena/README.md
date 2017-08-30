# HPCC Build: Athena

Setup environment:

```bash
module load gcc/6.3.0/1
module load intel/mpi/64/2017.2.174
module load intel/runtime/64/2016.3.210 
module load intel/mkl/64/2017.2.174
```

Copy Make.athena_gcc into hpl/ directory

Build:

```bash
make arch=athena_gcc
```

