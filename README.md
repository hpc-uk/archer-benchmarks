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

This repositiory contains:

* the information required to compile and run the benchmarks
* results and analysis from running the benchmarks on different HPC systems

This repository is work in progress and not all information is available yet.

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

## Application Benchmarks

* [CASTEP](apps/CASTEP)
* [CP2K](apps/CP2K)
* [GROMACS](apps/GROMACS)
* [OpenSBLI](apps/OpenSBLI) 
* OASIS (Met Office Unified Model coupled to NEMO ocean model)

# Systems Included

The following is a list of systems that have been benchmarked along with basic
information on their configuration (processor and memory information are **per node**).

**Note:** Not all benchmarks have been run on all systems.


## Compute node and interconnect

| System | Processor | Memory | Interconnect |
| ------ | --------- | ------ | ------------ |
| [ARCHER](http://www.archer.ac.uk) | 2x Intel E5-2697v2, 2.7GHz, 12-core | 64/128GB DDR3 4 channels (119.4GB/s) | Cray Aries, Dragonfly |
| [Cirrus](http://www.cirrus.ac.uk) | 2x Intel E5-2695v3, 2.1GHz, 18-core | 256GB DDR4, 4 channels (153.6GB/s) | FDR IB, Hypercube |
| [Athena](http://www.hpc-midlands-plus.ac.uk/) | 2x Intel E5-2680v4, 2.4GHz, 14-core | 128GB DDR4, 4 channels (153.6GB/s) | EDR IB, 27 node nonblocking, 3:1 backbone |
| [CSD3 Skylake](https://www.csd3.cam.ac.uk/) | 2x Intel Gold 6142, 2.6GHz, 16-core | 6 channels (238.4GB/s) | Intel OPA |
| [Thomas](https://wiki.rc.ucl.ac.uk/wiki/Thomas) | 2x Intel E5-2650v4, 2.1GHz, 12-core | 128GB DDR4, 4 channels (153.6GB/s) | Intel OPA, 36 node nonblocking, 3:1 backbone |

If you have any questions about these benchmarks, please contact the 
[ARCHER Helpdesk](mailto:support@archer.ac.uk).


## File systems

| System | File System | Versions | Vendor | Other details |
| ------ | ----------- | -------- | ------ | ------------- |
| [ARCHER](http://www.archer.ac.uk) | Lustre | Client: 2.5.2, Server: 2.1.0.0 | Cray Sonexion | 1x MDT, 48 OST |
| [Cirrus](http://www.cirrus.ac.uk) | Lustre | Client: 2.5, Server: 2.7 | DDN Lustre | 1x MDT, 14x OST |
| [Athena](http://www.hpc-midlands-plus.ac.uk/) | SpectrumScale/GPFS | 4.2.3-6/4.2.3-6 | IBM | N/A |
| [CSD3 Skylake](https://www.csd3.cam.ac.uk/) | Lustre | Client: 2.7, Server: 2.7 | Intel Enterprise Lustre | 1x MDT, 24x OST |
| [Thomas](https://wiki.rc.ucl.ac.uk/wiki/Thomas) | Lustre | DDN | 2.10.3/2.10.3 | 4x MDT, 10x OST |

# Contributing

To contribute to this effort, first you have to fork it on GitHub and clone it to your machine, see [Fork a Repo](https://help.github.com/articles/fork-a-repo/)
for the GitHub documentation on this process.

Once you have made your changes and updated your Fork on GitHub you will need to [Open a Pull Request](https://help.github.com/articles/using-pull-requests/).

If you would like to contribute, but do not know what to get involved with then take a look at the
[current issues](https://github.com/hpc-uk/archer-benchmarks/issues) for ideas of topics that could be worked on.

# Licence

The work in this repository is licensed under the [GNU General Public License version 3](https://opensource.org/licenses/GPL-3.0).

