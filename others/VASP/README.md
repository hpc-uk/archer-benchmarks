# VASP Benchmarks

There are two VASP benchmarks in the set: one using pure DFT functional
and one using a hybrid functional.

## Pure DFT functional benchmark: TiO2

This benchmark was originally sourced from the UK Materials Modelling Hub. Thanks to
them for sharing this benchmark.

The input for the TiO2 benchmark can be found in the [input subdirectory](TiO2/input/).
The POTCAR file needs to be constructed from your own VASP installation of the basis
set files. You will need the `Ti` and `O` PAW PBE basis set files concatenated together.

Data from the benchmark can be found in this repository:

* [Analysis of VASP TiO2 benchmark results](analysis/VASP_TiO2_perf_analysis.ipynb)
* [Output from VASP TiO2 benchmark runs](TiO2_MCC/results)

## Hybrid DFT functional benchmark: CdTe

The input for the small al3x3 benchmark can be found at:

* http://www.castep.org/CASTEP/Al3x3

Data from the benchmark can be found in this repository:

* [Analysis of CASTEP al3x3 benchmark results](analysis/CASTEP_al3x3_perf_analysis.ipynb)
* [Output from CASTEP al3x3 benchmark runs](al3x3/results)
* [Job submission scripts for CASTEP al3x3 benchmark runs](al3x3/run)

# Build instructions

The build process followed for CASTEP on each of the systems benchmarked (if available):

* [ARCHER](https://github.com/hpc-uk/build-instructions/blob/master/CASTEP/ARCHER_18.1.0_gcc6_CrayMPT.md)
* [Cirrus](https://github.com/hpc-uk/build-instructions/blob/master/CASTEP/Cirrus_18.1.0_intel17_HPEMPT.md)
* [Athena (HPC Mid+)](https://github.com/hpc-uk/build-instructions/blob/master/CASTEP/Athena_18.1.0_gcc6_IMPI.md)
* Thomas (MMMHub) - Central installation of CASTEP 17.2 used
* [CSD3-Skylake](https://github.com/hpc-uk/build-instructions/blob/master/CASTEP/CSD3Skylake_17.2.1_intel17_IMPI.md)
* [Isambard](https://github.com/hpc-uk/build-instructions/blob/master/CASTEP/Isambard_18.1.0_cce8_mpich3.md)
* [Tesseract](https://github.com/hpc-uk/build-instructions/blob/master/CASTEP/Tesseract_18.1.0_intel18_IMPI.md)



