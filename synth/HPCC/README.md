# HPC Challenge (HPCC)

This benchmark is used to test the MPI (and hence interconnect) performance and memory performance of the systems.
Although HPCC includes High Performance Linpack (HPL) this benchmark is not currently used on the systems.

HPCC Challenge was downloaded from;

* http://icl.cs.utk.edu/hpcc/

The benchmark was run in two configurations:

* b_eff - MPI (interconnect) performance measures
* STREAM - Memory performance measures

## Analysis

b_eff results are analysed in a Jupyter notebook:

* [b_eff performance analysis](analysis/beff_res_analysis.ipynb)

Parsing of the HPCC output file is performed by functions defined in a custom Python
module:

* [Synthetic benchmark performance analysis Python functions](../../python-modules/synthanalysis/hpcc.py)

STREAM results are read directly from the HPCC output files (links below).

## Compilation details

* [ARCHER (EPCC)](Make_arch/ARCHER/)
* [Cirrus (EPCC)](Make_arch/Cirrus/)
* [Athena (HPC Mid+)](Make_arch/Athena/)
* [CSD3-Skylake (Cambridge)](Make_arch/CSD3-Skylake/)
* [Thomas (MMM Hub)](Make_arch/MMM_Thomas/)

## Input configurations and job scripts

* [ARCHER (EPCC)](run/ARCHER/)
* [Cirrus (EPCC)](run/Cirrus/)
* [Athena (HPC Mid+)](run/Athena/)
* [CSD3-Skylake (Cambridge)](run/CSD3-Skylake/)
* [Thomas (MMM Hub)](run/MMM_Thomas/)

## Full output data: b_eff

* [ARCHER (EPCC)](beff_results/ARCHER/)
* [Cirrus (EPCC)](beff_results/Cirrus/)
* [Athena (HPC Mid+)](beff_results/Athena/)
* [CSD3-Skylake (Cambridge)](beff_results/CSD3-Skylake/)
* [Thomas (MMM Hub)](beff_results/MMM_Thomas/)

## Full output data: STREAM

* [ARCHER (EPCC)](stream_results/ARCHER/)
* [Cirrus (EPCC)](stream_results/Cirrus/)
* [Athena (HPC Mid+)](stream_results/Athena/)
* [CSD3-Skylake (Cambridge)](stream_results/CSD3-Skylake/)
* [Thomas (MMM Hub)](stream_results/MMM_Thomas/)

