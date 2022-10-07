# VASP Benchmarks

There are two VASP benchmarks in the set: one using pure DFT functional
and one using a hybrid functional.

## Pure DFT functional benchmark: TiO2

This benchmark was originally sourced from the UK Materials Chemistry Consortium. Thanks to
them for sharing this benchmark.

The input for the TiO2 benchmark can be found in the [input subdirectory](TiO2/input/).
The POTCAR file needs to be constructed from your own VASP installation of the basis
set files. You will need the `Ti` and `O` PAW PBE basis set files concatenated together.

Data from the benchmark can be found in this repository:

* [Analysis of VASP TiO2 benchmark results](analysis/VASP_TiO2_perf_analysis.ipynb)
* [Output from VASP TiO2 benchmark runs](TiO2_MCC/results)

## Hybrid DFT functional benchmark: CdTe

This benchmark was originally sourced from the UK Materials Chemistry Consortium. Thanks to
them for sharing this benchmark.

The input for the CdTe benchmark can be found in the [input subdirectory](CdTe/input/).
The POTCAR file needs to be constructed from your own VASP installation of the basis
set files. You will need the `Cd` and `Te` PAW PBE basis set files concatenated together.

Data from the benchmark can be found in this repository:

* [Analysis of VASP CdTe benchmark results](analysis/VASP_CdTe_perf_analysis.ipynb)
* [Output from VASP CdTe benchmark runs](CdTe_Hybrid/results)

# Build instructions

The build process followed for VASP on each of the systems benchmarked (if available):

ARCHER2:

* [ARCHER2, VASP 5.4.4.pl2](https://github.com/hpc-uk/build-instructions/blob/main/apps/VASP/build_vasp_5.4.4_ARCHER2_GCC.md)
* [ARCHER2, VASP 6.3.1](https://github.com/hpc-uk/build-instructions/blob/main/apps/VASP/build_vasp_6.3.1_ARCHER2_GCC.md)

ARCHER:
* [ARCHER, VASP 5.4.4.pl2](https://github.com/hpc-uk/build-instructions/blob/main/apps/VASP/build_vasp_5.4.4_ARCHER_Intel.md)
* [ARCHER, VASP 6.1.0](https://github.com/hpc-uk/build-instructions/blob/main/apps/VASP/build_vasp_6.1.0_ARCHER_Intel.md)



