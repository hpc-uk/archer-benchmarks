# UK HPC Benchmarking

This repository contains information, results and analysis of running a selection
of application and synthetic benchmarks on UK HPC systems. The list of systems
included to date is provided below.

This is an open source initiative and is keen to accept contributions from the
community. See the 'Contributing' section below on how to contribute results and
analyses.

The work in this repository would not be possible without the generous access and
support provided by the organisations running UK HPC systems, including:

* EPCC, The University of Edinburgh
* CSD3, Univeristy of Cambridge
* HPC Midlands+ Consortium
* GW4 Consortium
* MMM Hub, UCL
* The University of Oxford
* DiRAC

This repositiory contains:

* the information required to compile and run the benchmarks
* results and analysis from running the benchmarks on different HPC systems

This repository is work in progress and not all information is available yet.

# Reports

-   **29 March 2019** [Performance of HPC Application Benchmarks across UK National HPC services: single node performance](reports/single_node/index.md): Report comparing the single-node performance of different application benchmarks across different architecutres in UK HPC systems. Includes performance results, analysis and conclusions comparing three generations of Intel Xeon CPUs, Marvell Arm ThunderX2 CPUs and NVidia GPUs. [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.2616549.svg)](https://doi.org/10.5281/zenodo.2616549)


-   **13 June 2018** [Performance of HPC Benchmarks across UK National HPC services](reports/initial_comparison/index.md): Report comparing performance of different application benchmarks across CPU-based UK HPC systems. Includes advice for users on picking the appropriate service for their research along with performance results, analysis and conclusions. [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1288378.svg)](https://doi.org/10.5281/zenodo.1288378)

# Benchmarks

The benchmark suite contains both application and synthetic benchmarks.
The appplication benchmarks have been chosen with input from the user community
to represent their research. The initial aim was to find benchmarks that demonstrate
the performance of their research that can exploit large scaling. For those applications
where the scale-out benchmarks cannot run on small numbers of nodes we have supplemented
them with a smaller benchmark to compare the node performance. The synthetic benchmarks
have been chosen to provide an understanding of the limits of performance of different
components of the service.

The selection of the benchmarks is described in an ARCHER white paper:

* http://www.archer.ac.uk/documentation/white-papers/benchmarks/UK_National_HPC_Benchmarks.pdf

## Synthetic Benchmarks

* [HPC Challenge (HPCC)](synth/HPCC) - HPC Challenge: tests of floating-point, memory and interconnect performance
* [benchio](synth/benchio) - Test of parallel I/O write bandwidth using MPI-IO
* [mdtest](synth/mdtest) - Test of parallel file system metadata server (MDS) performance
* [Intel MPI Benchmarks (IMB)](synth/IMB) - Tests of MPI/interconnect performance, collective and point-to-point operation

## Application Benchmarks

* [CASTEP](apps/CASTEP)
* [CP2K](apps/CP2K)
* [GROMACS](apps/GROMACS)
* [OpenSBLI](apps/OpenSBLI) 
* [HadGEM3](apps/HadGEM3) (Met Office Unified Model coupled to NEMO ocean model using the OASIS coupling framework)

# Systems Included

The Jupyter notebook linked below provides a list of systems that have been benchmarked along with basic
information on their configuration.

* [Technical details of systems benchmarked](SystemDetails.ipynb)

**Note:** Not all benchmarks have been run on all systems.

# Contributing

To contribute to this effort, first you have to fork it on GitHub and clone it to your machine, see [Fork a Repo](https://help.github.com/articles/fork-a-repo/)
for the GitHub documentation on this process.

Once you have made your changes and updated your Fork on GitHub you will need to [Open a Pull Request](https://help.github.com/articles/using-pull-requests/).

If you would like to contribute, but do not know what to get involved with then take a look at the
[current issues](https://github.com/hpc-uk/archer-benchmarks/issues) for ideas of topics that could be worked on.

# Licence

The work in this repository is licensed under the [GNU General Public License version 3](https://opensource.org/licenses/GPL-3.0).

