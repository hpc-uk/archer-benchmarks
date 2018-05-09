# Parallel write bandwidth: benchio

This is the benchio parallel write bandwidth benchmark. This evaluates the performance of all
MPI processes using collective MPI-IO writes to a single file.

The souce code for the benchio benchmark application can be found at:

* https://github.com/EPCCed/benchio

## Benchmark details

The benchmark was compiled with local array size of (256,256,256) on all systems.

On all Lustre systems, the following Lustre settings were used:

* Lustre: 1 MiB stripe size, maximum striping

## Analysis

Results are analysed in a Jupyter notebook:

* [benchio performance analysis](analysis/benchio_write_perf_analysis.ipynb)

Parsing of the benchio output file is performed by functions defined in a custom Python
module:

* [Synthetic benchmark performance analysis Python functions](../../python-modules/synthanalysis/benchio.py)

## Compilation details

* [ARCHER (EPCC)](build/ARCHER/)
* [Cirrus (EPCC)](build/Cirrus/)
* Athena (HPC Mid+) - No results yet
* [CSD3-Skylake (Cambridge)](build/CSD3Skylake/)
* [Thomas (MMM Hub)](build/Thomas/)

## Job scripts

* [ARCHER (EPCC)](run/ARCHER/)
* [Cirrus (EPCC)](run/Cirrus/)
* Athena (HPC Mid+) - No results yet
* [CSD3-Skylake (Cambridge)](run/CSD3Skylake/)
* [Thomas (MMM Hub)](run/Thomas/)

## Full output data

* [ARCHER (EPCC)](results/ARCHER/)
* [Cirrus (EPCC)](results/Cirrus/)
* Athena (HPC Mid+) - No results yet
* [CSD3-Skylake (Cambridge)](results/CSD3Skylake/)
* [Thomas (MMM Hub)](results/Thomas/)





