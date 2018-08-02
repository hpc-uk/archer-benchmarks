# OpenSBLI

A full description of the OpenSBLI benchmark is provided below. The source for the benchmark can be found in this repository.

* [Run scripts for OpenSBLI on different platforms](run/)
* [Building OpenSBLI on different platforms](source/README.md)
* [OpenSBLI benchmark source code](https://github.com/ARCHER-CSE/archer-benchmarks/tree/master/apps/OpenSBLI/source)

# OpenSBLI Benchmark Information

Satya P Jammy

Aerodynamics and Flight Mechanics Research group, University of Southampton, U.K

## Overview

The benchmark test case setup using OpenSBLI is the Taylor-Green vortex problem in a cubic domain of length 2pi. The code was setup to compute the validation, strong scaling and weak scaling simulations across architectures.

## Large size (1024): strong scaling

* [Large size (1024), strong scaling performance analysis](analysis/OpenSBLI_1024ss_benchmark.ipynb)
* [Large size (1024), strong scaling results](TGV1024ss/)

For the large size, strong scaling benchmark the input file `input` shoukd be set to:

```
ss 1024 100 0
```

These options indicate:

- `ss` - Strong scaling
- `1024` - 1024 cubed size
- `100` - 100 iterations
- `0` - Do not write HDF5 output


## Medium size (512): strong scaling

* [Medium size (512), strong scaling performance analysis](analysis/OpenSBLI_512ss_benchmark.ipynb)
* [Medium size (512), strong scaling results](TGV512ss/)

For the medium size, strong scaling benchmark the input file `input` shoukd be set to:

```
ss 512 100 0
```

These options indicate:

- `ss` - Strong scaling
- `512` - 512 cubed size
- `100` - 100 iterations
- `0` - Do not write HDF5 output

# Example job submission scripts

- ARCHER
- Cirrus
- Athena
- Thomas
- Peta4 Skylake
- Isambard


