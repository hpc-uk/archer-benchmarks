# CASTEP Benchmarks

There are two CASTEP benchmarks in the set as the large benchmark cannot
be run on low node counts. The small benchmark allows the low node count
performance to be compared across systems.

## Large benchmark: DNA

The input for the large DNA benchmark can be found at:

* http://www.castep.org/CASTEP/DNA

Data from the benchmark can be found in this repository:

* [Analysis of CASTEP DNA benchmark results](analysis/CASTEP_DNA_perf_analysis.ipynb)
* [Output from CASTEP DNA benchmark runs](DNA/results)


## Small benchmark: Al3x3

The input for the small Al3x3 benchmark can be found at:

* http://www.castep.org/CASTEP/Al3x3

Data from the benchmark can be found in this repository:

* [Analysis of CASTEP Al3x3 benchmark results](analysis/CASTEP_al3x3_perf_analysis.ipynb)
* [Output from CASTEP Al3x3 benchmark runs](al3x3/results)

# Build instructions

The build process followed for CASTEP on each of the systems benchmarked (if available):

* [ARCHER](https://github.com/hpc-uk/build-instructions/blob/master/CASTEP/ARCHER_18.1.0_gcc6_CrayMPT.md)
* [Cirrus](https://github.com/hpc-uk/build-instructions/blob/master/CASTEP/Cirrus_16.1.1_intel17_HPEMPT.md)
* [Athena (HPC Mid+)](https://github.com/hpc-uk/build-instructions/blob/master/CASTEP/Athena_18.1.0_gcc6_IMPI.md)
* Thomas (MMMHub) - Central installation of CASTEP 17.2 used
* [CSD3-Skylake](https://github.com/hpc-uk/build-instructions/blob/master/CASTEP/CSD3Skylake_17.2.1_intel17_IMPI.md)



