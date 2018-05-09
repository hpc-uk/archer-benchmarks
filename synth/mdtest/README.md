# Metadata Benchmark: mdtest

This synthetic benchmark probes the metadata server (MDS) performance. The source
code for mdtest is available as part of the LANL IOR distribution at:

* https://github.com/IOR-LANL/ior

## Benchmark details

The benchmark cofigurations were those specified in the Trinity benchmark suite:

* http://www.nersc.gov/users/computational-systems/cori/nersc-8-procurement/trinity-nersc-8-rfp/nersc-8-trinity-benchmarks/mdtest/

i.e.:

* Creating 1,048,576 files by one process in one directory;
* Removing those 1,048,576 files;
* Creating 1,048,576 files by NP processes in separate directories, one directory per process.
* Removing those 1,048,576 files;
* Creating 1,048,576 files by NP processes in the same directory;
* Removing those 1,048,576 files;
* Creating 1 file by NP processes.
* Removing that 1 file by NP processes. 

## Analysis

Results are analysed in a Jupyter notebook:

* [mdtest performance analysis](analysis/mdtest_perf_analysis.ipynb)

Parsing of the benchio output file is performed by functions defined in a custom Python
module:

* [Synthetic benchmark performance analysis Python functions](../../python-modules/synthanalysis/mdtest.py)

## Compilation details

* [ARCHER (EPCC)](build/ARCHER/)
* [Cirrus (EPCC)](build/Cirrus/)
* Athena (HPC Mid+) - No results yet
* [CSD3-Skylake (Cambridge)](build/CSD3Skylake/)
* Thomas (MMM Hub) - No results yet

## Job scripts

* [ARCHER (EPCC)](run/ARCHER/)
* [Cirrus (EPCC)](run/Cirrus/)
* Athena (HPC Mid+) - No results yet
* [CSD3-Skylake (Cambridge)](run/CSD3Skylake/)
* Thomas (MMM Hub) - No results yet

## Full output data

* [ARCHER (EPCC)](results/ARCHER/)
* [Cirrus (EPCC)](results/Cirrus/)
* Athena (HPC Mid+) - No results yet
* [CSD3-Skylake (Cambridge)](results/CSD3Skylake/)
* Thomas (MMM Hub) - No results yet

