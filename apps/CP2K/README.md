# CP2K Benchmark

## Introduction

We use the LiH-HFX benchmark. According to the [CP2K benchmarks](https://www.cp2k.org/performance) page:

"This is a single-point energy calculation using Quickstep GAPW (Gaussian and Augmented Plane-Waves) with hybrid Hartree-Fock exchange. It consists of a 216 atom Lithium Hydride crystal with 432 electrons in a 12.3 Å3 cell. These types of calculations are generally around one hundred times the computational cost of a standard local DFT calculation, although this can be reduced using the Auxiliary Density Matrix Method (ADMM). Using OpenMP is of particular benefit here as the HFX implementation requires a large amount of memory to store partial integrals. By using several threads, fewer MPI processes share the available memory on the node and thus enough memory is available to avoid recomputing any integrals on-the-fly, improving performance. "

_This benchmark is best for large core/node counts (>128 nodes) as it requires a lot of memory. Using fewer than this number of nodes results in an out of memory error._

## Compiling CP2K
Instructions for compiling CP2K (for ARCHER) can be found [here](https://github.com/hpc-uk/build-instructions/blob/master/CP2K/CP2K_6.1_ARCHER.md).


## Required files
The input and data files required for this benchmark can be found in the `input` directory in this repository. The submit scripts can be found in the `job_scripts` directory, also in this repository.

## Results
Results from this benchmark can be found in the `results` directory of this repository. Each run was completed using 6 OpenMP threads per MPI process.



# Setup calculation

In order to run the benchmark, first a setup calculation must be performed to produce an input wave function file. This calculation can be carried out on 8 nodes, taking around 3 minutes.

To run this setup calculation, copy `input_bulk_B88_3.inp` and `BASIS_OPT` into a working directory. Also copy the batch script `setup_ARCHER.pbs` into this working directory, remembering to change the budget code, and path to the `CP2K.psmp` executable. Now submit this job (the runtime is short enough that it can be submitted to the short queue on ARCHER).

Once the job has completed, rename `LiH_bulk_3-RESTART.wfn` to `B88.wfn`. This is the input file required by the benchmark.


# Running the benchmark
Once the input file `B88.wfn` has been created (see above), the main benchmark calculation can be run. Copy `input_bulk_HFX_3.inp`, `BASIS_OPT` and `B88.wfn` into a working directory.

Also copy the `LiH_HFX_ARCHER.pbs` batch script into your work directory, remembering to change the budget code, path to the `CP2K.psmp` executable, as well as the node/core/thread counts to the appropriate values. __Please note:__ the benchmark requires a lot of memory, so must be run on 128 or more nodes. Also, using several OpenMP threads per MPI process is beneficial for saving memory.

Once the benchmark has completed (typically takes <10 minutes) the time taken can be determined from the job's output by looking for `CP2K` in the timing information:

```
-------------------------------------------------------------------------------
 -                                                                             -
 -                                T I M I N G                                  -
 -                                                                             -
 -------------------------------------------------------------------------------
 SUBROUTINE                       CALLS  ASD         SELF TIME        TOTAL TIME
                                MAXIMUM       AVERAGE  MAXIMUM  AVERAGE  MAXIMUM
 CP2K                                 1  1.0    0.178    0.295  200.814  200.816
 qs_energies                          1  2.0    0.000    0.000  200.091  200.093
 scf_env_do_scf                       1  3.0    0.000    0.000  198.017  198.018
 qs_ks_update_qs_env                  8  5.0    0.000    0.000  161.422  161.440
 rebuild_ks_matrix                    7  6.0    0.000    0.000  161.419  161.437
 qs_ks_build_kohn_sham_matrix         7  7.0    0.001    0.001  161.419  161.437
 hfx_ks_matrix                        7  8.0    0.000    0.000  154.464  154.495
```
Or by using `grep`, e.g.

```
$ grep "CP2K      " CP2K_256.o5608893
 CP2K                                 1  1.0    0.178    0.295  200.814  200.816
```
