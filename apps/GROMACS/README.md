# GROMACS Benchmarks

There are two GROMACS benchmarks in the set. The large benchmark allows the scaling of GROMACS
to be evaluated up to large core counts while the small benchmark provides information on 
a more typical research problem and allows for comparisons on smaller node counts and 
with GPU-based systems.

## Large Benchmark

### Run options

In all cases, the following options were specified to `mdrun`:

* `-noconfout`
* `-ntomp <number of OMP threads>` (where `<number of OMP threads>` is replaced by the number of OpenMP threads used).

### Input data

There are two sets of input data for this benchmark: one in binary format (the GROMACS tpr file) and 
the original raw files that can be used to regenerate the tpr file if required. If possible, the 
binary tpr file should be used. Both sets of input data are too large to be hosted on Github and 
so are available from external file hosting sites.

* [Binary tpr file (nsteps800.tpr, 1.6GB, password: "gromacs")](https://datasync.ed.ac.uk/index.php/s/49Qg4UVsYE2EjvL)
* [Raw input files (ARCHER_GROMACS_large.tar.gz, 628 MB, password: "gromacs")](https://datasync.ed.ac.uk/index.php/s/JutDxHuyvMaCe7a)

#### Generating the binary tpr file from the raw input data

If you have downloaded and extracted the raw input files, you can convert to the binary tpr input
file with the following command (assuming you have the ``gmx`` command in your path):

```bash
gmx grompp -f amber-full.mdp -c nc2.gro -p nc2.top -o nsteps800.tpr
```

Note that this will take a long time and may be better performed in a job script!

### Results and analysis

Data from the benchmark can be found in this repository:

* [Analysis of large GROMACS benchmark results](analysis/GROMACS_large_perf_analysis.ipynb)
* [Output from large GROMACS benchmark runs](large/results)

### Example job scripts

Example job scripts can be found in this repository:

* [Example job submission scripts from large GROMACS benchmark](large/run/)

## Small benchmark: 1400k-atom (pair of hEGFR Dimers of 1IVO and 1NQL)

### Run options

In all cases, the following options were specified to `mdrun`:

* `-noconfout`
* `-ntomp <number of OMP threads>` (where `<number of OMP threads>` is replaced by the number of OpenMP threads used).

### Input data

The input data for this benchmark is available from the HEC BioSim benchmark pages at:

* http://www.hecbiosim.ac.uk/benchmarks

A copy of the input file as used in these runs is also available in this repository:

* [1400k-atoms/input/benchmark.tpr](1400k-atoms/input/benchmark.tpr)

### Results and analysis

Data from the benchmark can be found in this repository:

* [Analysis of 1400k atom GROMACS benchmark results](analysis/GROMACS_1400k-atoms_perf_analysis.ipynb)
* [Output from large GROMACS benchmark runs](1400k-atoms/results)

### Example job scripts

Example job scripts can be found in this repository:

* [Example job submission scripts from 1400k atoms GROMACS benchmark](1400k-atoms/run/)

## Build instructions

The build process followed for GROMACS on each of the systems benchmarked (if available):

* [ARCHER (EPCC)](https://github.com/hpc-uk/build-instructions/blob/master/GROMACS/ARCHER_2016.3_gcc5_ivybrg.md)
* [Cirrus (EPCC)](https://github.com/hpc-uk/build-instructions/blob/master/GROMACS/Cirrus_2016.3_gcc6.md)
* [Athena (HPC Mid+)](https://github.com/hpc-uk/build-instructions/blob/master/GROMACS/Athena_2016.3_gcc6.md)
* Thomas (MMMHub) - Used central install of GROMACS 2016.3
* [Peta4-Skylake](https://github.com/hpc-uk/build-instructions/blob/master/GROMACS/CSD3Skylake_2016.4_gcc7.md)

