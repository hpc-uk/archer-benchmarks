# ARCHER and EPSRC Tier-2 HPC Benchmarking

This repository contains information, results and analysis of running a selection
of application and synthetic benchmarks on UK HPC systems. The list of systems
included to date is provided below.

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

* [HPC Challenge (HPCC)](synth/HPCC)
* benchio
* mdtest

## Application Benchmarks

* [CASTEP](apps/CASTEP)
* [CP2K](apps/CP2K)
* [GROMACS](apps/GROMACS)
* [OpenSBLI](apps/OpenSBLI) 
* Met Office Unified Model

# Systems Included

The following is a list of systems that have been benchmarked along with basic
information on their configuration (processor and memory information are **per node**).

**Note:** Not all benchmarks have been run on all systems.

| System | Processor | Memory | Interconnect |
| ------ | --------- | ------ | ------------ |
| [ARCHER](http://www.archer.ac.uk) | 2x Intel E5-2697v2, 2.7GHz, 12-core | 64/128GB DDR3 4 channels (119.4GB/s) | Cray Aries, Dragonfly |
| [Cirrus](http://www.cirrus.ac.uk) | 2x Intel E5-2695v3, 2.1GHz, 18-core | 256GB DDR4, 4 channels (153.6GB/s) | FDR IB, Hypercube |
| [Athena](http://www.hpc-midlands-plus.ac.uk/) | 2x Intel E5-2680v4, 2.4GHz, 14-core | 128GB DDR4, 4 channels (153.6GB/s) | EDR IB, 27 node nonblocking, 3:1 backbone |
| [CSD3 Skylake](https://www.csd3.cam.ac.uk/) | 2x Intel Gold 6142, 2.6GHz, 16-core | 6 channels (238.4GB/s) | Intel OPA |
| [Thomas](https://wiki.rc.ucl.ac.uk/wiki/Thomas) | 2x Intel E5-2650v4, 2.1GHz, 12-core | 128GB DDR4, 4 channels (153.6GB/s) | Intel OPA, 36 node nonblocking, 3:1 backbone |

If you have any questions about these benchmarks, please contact the 
[ARCHER Helpdesk](mailto:support@archer.ac.uk).
