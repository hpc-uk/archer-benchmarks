# OpenSBLI

A full description of the OpenSBLI benchmark is provided below. The source for the benchmark can be found in this repository.

* [Analysis of OpenSBLI performance](https://github.com/ARCHER-CSE/archer-benchmarks/blob/master/apps/OpenSBLI/analysis/OpenSBLI_benchmark.ipynb)
* [Results from running OpenSBLI](https://github.com/ARCHER-CSE/archer-benchmarks/tree/master/apps/OpenSBLI/results)
* [OpenSBLI benchmark source code](https://github.com/ARCHER-CSE/archer-benchmarks/tree/master/apps/OpenSBLI/source)

# OpenSBLI Benchmark Instructions

Satya P Jammy

Aerodynamics and Flight Mechanics Research group, University of Southampton, U.K

## Introduction

The benchmark test case setup using OpenSBLI is the Taylor-Green vortex problem in a cu- bic domain of length 2 π. The code was setup to compute the validation, strong scaling and weak scaling simulations across architectures. The rest of the document explains setting up the various types of simulations, dependant libraries, compiling and running the simulation.

## Simulations

OpenSBLI benchmark test case uses an input file (filename is fixed as input and its location is the working directory). The input file contains the control parameters for the type of simula- tion, number of grid points, number of iterations, number of processors, and write output (HDF5 file). The format of the input file is,

1 string(size2) int int int string

The output written by all the simulations include the following

- The type of simulation, number of grid points per direction, total number of grid points (nx3)
- The domain decomposition, if applicable i.e. if using MPI
- Total wall-time of the time loop (number of iterations)
- run-time per iteration, i.e. wall-time/number of iterations
- If HDF5 file I/O is specified the time taken for writing the file

### Validation

To validate the code the user needs to specify the type of simulation as va, the inputs (2-4) will not have an effect on the simulation. The number of grid points and iterations are predefined as 128 and 500 respectively.

 type_of_simulation number_of_grid_points_per_direction number_of_iterations number_of_processes write_HDF5
and the corresponding data types and sizes are,

#### Set-up example

An example input file to run the validation simulation without writing HDF5 output file would be,

1 va 256 10 12 False

In the above example, the user can activate HDF5 I/O by setting the last parameter to True, in
such a case the input file would be,

1 va 256 10 12 True

#### Output

Along with the common outputs specified at the start of the simulation the sum of kinetic energy, enstrophy and density are printed to the screen. If the numbers given by the simulation match the following line then the simulation is considered as valid.

1 0.84625, 261319, 844254, 2.09715e+06

### Strong scaling

To perform strong scaling simulations the type of simulation (first input) in the input file should be ss. The second and third inputs should be set by the user. The second input corresponds to the number of grid points in each direction (we carried out strong scaling on ARCHER by setting this number as 1024). The simulation will be run for second_inp3 gridpoints for third_input iterations. The fourth_input will have no effect in this simulation and the fifth_input can be used for I/O tests (if required set this to 0).

#### Set-up example

An example, input file to do strong scaling simulations using a grid size of 10243, for 100 iterations without file I/O would be,

1 ss 1024 100 0 False

#### Output

The output for the strong scaling tests are same as outlined at the starting of the section.

### Weak scaling

Similarly to perform the weak scaling simulations, the first input would be ws, the second input will correspond to the number of grid points per process. The third input is the number of iterations for the simulations. The fourth input is the number of processors the user wants the weak scaling simulation to be performed. Depending on this number the dimensions of the problem will be scaled, this is done to avoid very fine grid at higher processor count.

The grid size of the weak scaling simulations would be (second_input ∗ fourth_input)3, run- ning on f ourth_input number of processors for third_input iterations.

#### Set-up example

An example input file to do the weak scaling simulation with 323 grid points per process using 64 MPI processes for 100 iterations would be,

1 ws 32 100 64 False

#### Output

The output for the weak scaling tests are same as outlined at the starting of the section.

## Compiling

OpenSBLI depends on the OPS framework. OPS should be compiled before compiling the benchmark application. The OPS version that is tested for the current setup is provided along with the source files in the directory OpenSBLI/OPS/ follow the instructions in the README file in this directory to install OPS. Further details can be found at OPS website , the latest source code of OPS can be downloaded from the github repository link there .

To compile the benchmark test case user should modify the makefile provided in the application directory of OpenSBLI (OpenSBLI/benchmark/) by setting the correct compiler flags for the architecture used along with the OPS library install path.

Compiling the benchmark case on MPI and CUDA can be done using the following commands,

```bash
make OpenSBLI_mpi
make OpenSBLI_cuda
```

The current architectures that are supported and tested by the OPS library are the following,

Once the application is compiled, it can be run on the architecture.

The benchmark application is translated to various architectures using the OPS translator and is provided and no translation is required for the benchmark test case as specified in the user guide at OPS website. If needed the user can add the C code for any other timer calls directly into taylor_green_vortex_ops.cpp.

