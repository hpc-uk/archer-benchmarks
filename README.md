# ARCHER Benchmarks

[ARCHER](http://www.archer.ac.uk) is the UK national supercomputing service
hosted, supported and adminstered by [EPCC](http://www.epcc.ed.ac.uk) at
the [University of Edinburgh](http://www.ed.ac.uk).

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

This repositiory contains:

* the information required to compile and run the benchmarks
* results and analysis from running the benchmarks on different HPC systems

This repository is work in progress and not all information is available yet.

## Synthetic Benchmarks

* [HPC Challenge (HPCC)](synth/HPCC)
* benchio

## Application Benchmarks

* [CASTEP](apps/CASTEP)
* [CP2K](apps/CP2K)
* [GROMACS](apps/GROMACS)
* [OpenSBLI](apps/OpenSBLI) 
* Met Office Unified Model

If you have any questions about these benchmarks, please contact the 
[ARCHER Helpdesk](mailto:support@archer.ac.uk).
