# GROMACS Benchmarks

## Large Benchmark

### Input data

There are two sets of input data for this benchmark: one in binary format (the GROMACS tpr file) and 
the original raw files that can be used to regenerate the tpr file if required. If possible, the 
binary tpr file should be used. Both sets of input data are too large to be hosted on Github and 
so are available from external file hosting sites.

* [Binary tpr file (nsteps800.tpr, 1.6GB)](https://nofile.io/f/WUKmah5qsgb/nsteps800.tpr)
* [Raw input files (ARCHER_GROMACS_large.tar.gz, 628 MB)](https://nofile.io/f/o2uH3AOd10C/ARCHER_GROMACS_large.tar.gz)

#### Generating the binary tpr file from the raw input data

If you have downloaded and extracted the raw input files, you can convert to the binary tpr input
file with the following command (assuming you have the ``gmx`` command in your path):

```bash
gmx grompp -f amber-full.mdp -c nc2.gro -p nc2.top -o nsteps800.tpr
```

Note that this will take a long time and may be better performed in a job script!

### Results and analysis

Data from the benchmark can be found in this repository:

* [Analysis of large GROMACS benchmark results](analysis/GROMACS_large_perf_analysis.ipynb)
* [Output from large GROMACS benchmark runs](large/results)

### Job scripts

* [ARCHER (EPCC)](run/ARCHER)
* [Cirrus (EPCC)](run/Cirrus)
* [Athena (HPC Mid+)](run/Athena)
* [Thomas (MMMHub)](run/Thomas)
* [Peta4-Skylake](run/CSD3Skylake)

## Build instructions

The build process followed for GROMACS on each of the systems benchmarked (if available):

* [ARCHER (EPCC)](https://github.com/hpc-uk/build-instructions/blob/master/GROMACS/ARCHER_2016.3_gcc5_ivybrg.md)
* [Cirrus (EPCC)](https://github.com/hpc-uk/build-instructions/blob/master/GROMACS/Cirrus_2016.3_gcc6.md)
* [Athena (HPC Mid+)](https://github.com/hpc-uk/build-instructions/blob/master/GROMACS/Athena_2016.3_gcc6.md)
* Thomas (MMMHub) - Used central install of GROMACS 2016.3
* [Peta4-Skylake](https://github.com/hpc-uk/build-instructions/blob/master/GROMACS/CSD3Skylake_2016.4_gcc7.md)

