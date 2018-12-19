# Performance of HPC Application Benchmarks across UK National HPC services: single node performance

Andy Turner ([a.turner@epcc.ed.ac.uk](mailto:a.turner@epcc.ed.ac.uk)), EPCC, The University of Edinburgh

<img src="img/epcc_logo.png" width="300"/>

## 0. Contents

1. [Introduction](#introduction)
2. [HPC Systems](#systems)
3. [Application Benchmarks](#apps)
4. [Summary and Conclusions](#summary)
5. [Acknowledgements](#acknowledgements)

<a id="introduction"></a>
## 1. Introduction

In a [previous report](https://github.com/hpc-uk/archer-benchmarks/blob/master/reports/initial_comparison/index.md) we
compared the performance of a number of different Intel Xeon UK national HPC systems using a range of different benchmarks;
including both application benchmarks and synthetic benchmarks. In this report we broaden the study to compare the 
performance of different processor architectures for the application benchmarks. To reduce the complexity of the comparisons,
we restrict the results in this report to single node only. This allows us to compare the performance of the different
compute node architerctures without the additional complexity of also comparing different interconnect technologies and
topologies. Multi-node comparisons will be the subject of a future report.

As before, the approach taken is to try and evaluate the performance that a standard user would see on the systems.
In particular, this means that large amounts of effort have not been put into optimising the applications used for the application benchmarks in the system. We have used standard central installations of packages where they exist, are accessible to standard users, and have the functionality required for the benchmarks. If central installations do not exist, the applications have been compiled in the standard, recommended way for the systems. All benchmarks have been run on the systems in general production, *i.e.* other user jobs are running as usual when the benchmarks are running. This allows us to experience the same system conditions and potential variability in performance that normal users would see. 

All of the raw data and analysis of the data are available under an Open Source licence from Github at:

-   <https://github.com/hpc-uk/archer-benchmarks>

Along with the analyses, a major goal of this initiative is to present an open set of results and analysis that can be added to by interested parties and built on and used for further analysis by groups other than ourselves. This philosophy of open contribution and public visibility mirrors that found in the Open Source and Open Data movements and, it is hoped, will allow everyone to extract the most value possible from the benchmarking data.

The benchmark applications and benchmark cases were selected with the input of the user community from ARCHER: the UK national supercomputing service. The approach to choosing the benchmarks is described in more detail in an ARCHER white paper:

-   [UK National HPC Benchmarks (PDF)](http://www.archer.ac.uk/documentation/white-papers/benchmarks/UK_National_HPC_Benchmarks.pdf)

The remainder of this paper is organised in the following way. Section 2 describes the HPC systems included in this study; Section 3 looks at the differences in performance across different application benchmarks. We conclude with a summary of the results and discussion of future work in this area in Section 4.

<a id="systems"></a>
## 2. HPC Systems

This initial benchmarking exercise covered five UK national HPC systems:

-   ARCHER: The UK national supercomputing service, <http://www.archer.ac.uk>
-   Cirrus: Tier2 HPC system provided by EPCC, <http://www.cirrus.ac.uk>
-   Athena: Tier2 HPC system provided by HPC Midlands Plus, <http://www.hpc-midlands-plus.ac.uk/>
-   Thomas: Tier2 HPC system provided by the Materials and Molecular Modelling Hub, <https://mmmhub.ac.uk/>
-   Peta4-Skylake: One component of the CSD3 Tier2 HPC system provided by the University of Cambridge, <http://www.csd3.cam.ac.uk>

The tables below provide further technical details on the systems. [Table 1](#tab1) provides information on the size of the system and the interconnect; [Table 2](#tab2) provides information on the compute node layout, [Table 3](#tab3) provides information on the processor memory hierarchy; and [Table 4](#tab4) provides information on the parallel file systems.

<a id="tab1"></a>Table 1: System details for the HPC services used in this study

| System        | CPU                         | Accelerator  | EPSRC Tier2 Grant Award         |
|---------------|-----------------------------|--------------|---------------------------------|
| ARCHER        | Intel Xeon (Ivy Bridge)     | None         | N/A                             |
| Cirrus        | Intel Xeon (Broadwell)      | None         | £2.4 million                    |
| Peta4-Skylake | Intel Xeon (Skylake Gold)   | None         | £5.0 million as part of Cumulus |
| Wilkes2-GPU   | Intel Xeon (Broadwell)      | NVidia P100  | £5.0 million as part of Cumulus |
| JADE          | Intel Xeon (Broadwell)      | NVidia P100  | £3.0 million                      |
| Isambard      | Marvell Arm ThunderX2       | None         | £3.0 million                      |
| Tesseract     | Intel Xeon (Skylake Silver) | None         | N/A                             |


<a id="tab2"></a>Table 2: Node CPU details for the HPC services used in this study

| System        | Processors                            | Cores per node  | Memory per node |
|---------------|---------------------------------------|-----------------|-----------------|
| ARCHER        | Intel E5-2697v2 (Ivy Bridge), 2.7 GHz | 24 (2x 12-core) | 64/128 GB       |
| Cirrus        | Intel E5-2695v4 (Broadwell), 2.1 GHz  | 36 (2x 18-core) | 256 GB          |
| Peta4-Skylake | Intel Gold 6142 (Skylake), 2.6 GHz    | 32 (2x 16-core) | 192/384 GB      |
| Wilkes2-GPU   | Intel E5-2660v4 (Broadwell), 2.2 GHz  | 12 (1x 12-core) | 192/384 GB      |
| JADE          | Intel E5-2698v4 (Broadwell), 2.2 GHz  | 40 (2x 20-core) | 96 GB           |
| Isambard      | Marvell Arm ThunderX2, 2.2 GHz        | 64 (2x 32-core) | 256 GB          |
| Tesseract     | Intel Silver 4112 (Skylake), 2.1 GHz  | 24 (2x 16-core) | 96 GB           |



<a id="tab3"></a>Table 3: Processor memory details for the HPC services used in this study

| System        | L1 data cache (per core) | L2 cache (per core) | L3 cache (shared) | Memory channels per socket | Published memory bandwidth per socket (node) |
|---------------|-------------------------:|--------------------:|------------------:|---------------------------:|---------------------------------------------:|
| ARCHER        | 32 KiB                   | 256 KiB             | 30 MiB            | 4                          | 59.7 (119.4) GB/s                            |
| Cirrus        | 32 KiB                   | 256 KiB             | 45 MiB            | 4                          | 76.8 (153.6) GB/s                            |
| Peta4-Skylake | 32 KiB                   | 1024 KiB            | 22 MiB            | 6                          | 119.2 (238.4) GB/s                           |
| Wilkes2-GPU | 32 KiB                   | 1024 KiB            | 22 MiB            | 6                          | 119.2 (238.4) GB/s                           |
| JADE| 32 KiB                   | 1024 KiB            | 22 MiB            | 6                          | 119.2 (238.4) GB/s                           |
| Isambard | 32 KiB                   | 256 KiB            | 32 MiB            | 8                          | 160.0 (320.0) GB/s                           |
| Tesseract | 32 KiB                   | 1024 KiB            | 22 MiB            | 6                          | 119.2 (238.4) GB/s                           |

<a id="tab4"></a>Table 4: Node accelerator details for the HPC services used in this study

| System        | Accelerator Model | Accelerator Memory |
|---------------|-------------------|-------------------:|
| Wilkes2-GPU   | P100-SXM2-16GB    | 16 GB              |
| JADE          | P100-SXM2-16GB    | 16 GB              |

<a id="apps"></a>
## 3. Application Benchmarks

In this initial performance comparison, we have run three benchmarks using three different applications:

-   [CASTEP](#castep): Al Slab benchmark (not on GPU systems)
-   [OpenSBLI](#osbli): Taylor-Green vortex 512^3 benchmark (not on GPU systems)
-   [GROMACS](#gromacs): 1400k atom benchmark

More details on these benchmarks are found in the individual sections below.

<a id="castep"></a>
### 3.1 CASTEP

[CASTEP](http://www.castep.org) is a general-purpose, DFT-based, materials science application. Written in Fortran with MPI and OpenMP parallelism.

Details of the compile options, job submission scripts, the full output data and analysis scripts are available on GitHub at:

-   <https://github.com/hpc-uk/archer-benchmarks/tree/master/apps/CASTEP>

The CASTEP application does not currently support execution on GPU accelerators (although this functionality is currently
under development by the CASTEP team) so we only include results for CPU-based systems.

We have measured the performance of the **Al Slab (al3x3)** benchmark that is able to run on small node counts. We expect the performance of this benchmark to depend on the memory-bandwidth and floating-point performance of the processors. This is a strong scaling benchmark.

**Note:** *Strong scaling* is where the number of parallel processes/threads is increased while the problem size is kept the same. This generally leads to each process/thread having less computational work as the number of processes/threads is increased.

We compare the single-node performance in [Table 5](#tab5). The performance is measured in mean SCF cycles per second (i.e. 1 / mean SCF cycle time). All the raw data for the table can be found in the repository linked above. The single node performance comparison reveals that the nodes with the latest generation of Intel Xeon processors (Pet4-Skylake) give a 3x performance improvement over ARCHER nodes, Broadwell processors give 2x performance increase a when compared to ARCHER.

<a id="tab5"></a>Table 5: Single node performance comparison for CASTEP Al Slab benchmark

| System        | Performance (mean SCF cycles/s) | Performance relative to ARCHER node | Notes        |
|---------------|--------------------------------:|------------------------------------:|--------------|
| Peta4-Skylake | 0.01641                         | 3.023                               | 32 MPI tasks |
| Cirrus        | 0.01109                         | 2.043                               | 36 MPI tasks |
| Tesseract     | 0.00728                         | 1.341                               | 24 MPI tasks |
| Isambard      | 0.00691                         | 1.273                               | 64 MPI tasks |
| ARCHER        | 0.00543                         | 1.000                               | 24 MPI tasks |

To help understand these results, we have used the STREAM benchmark (run within the HPC Challenge synthetic benchmark suite) to measure the memory bandwidth on the different systems. The results from the Triad metric running on all cores on a compute node simultaneously are shown in [Table 6](#tab6). The major difference in measured memory bandwidth per node comes from the generation of processors (and memory) with the newest generation (Peta4-Skylake) having by far the highest memory bandwidth per node (due both the newer technology and additional memory channels available) and the oldest generation (ARCHER) having the lowest memory bandwidth per node). For the systems with the Broadwell generation on processors having more cores per node allows you to access slightly higher measured memory performance per node this actually results in lower measured memory bandwidth *per core* as the additional cores compete for memory bandwidth.

<a id="tab6"></a>Table 6: Results from HPCC StarSTREAM Triad benchmark

| System        | Cores per node | StarSTREAM per core (GB/s) | StarSTREAM per node (GB/s) |
|---------------|---------------:|---------------------------:|---------------------------:|
| Tesseract     | 24             | 5.181                      | 124.339                    |
| Peta4-Skylake | 32             | 4.508                      | 144.256                    |
| Isambard      | 64             | 3.461                      | 221.485                    |
| ARCHER        | 24             | 3.036                      | 72.864                     |
| Cirrus        | 36             | 2.718                      | 97.848                     |

The two Intel Xeon Skylake systems (Tesseract, Skylake Silver, and Peta4-Skylake, Skylake Gold) show the highest per 
core memory bandwidth (as measured by StarSTREAM Triad) with the Marvell ThunderX2 Arm64 system (Isambard) having the 
highest per-node memory bandwidth. 

Using the memory bandwidth data, we see that the single node CASTEP Al Slab performance is a function of both node performance (influenced by both the performance per core and the number of cores per node) and memory bandwidth per core; with higher floating-point performance and memory bandwidth leading to higher CASTEP performance. In general, the floating-point performance of the nodes seems to dominate the performance on a single node. This conclusion is supported by the following facts:

-   ARCHER (which has the oldest processors in the study) and joint fewest cores per node shows the worst performance per
    node for this benchmark yet has similar memory bandwidth per core to the Cirrus system with Broadwell generation Xeon processors. The lower performance on ARCHER is due to the lower floating-point performance of a node.
-   Cirrus shows twice the performance of ARCHER even though the per-core memory bandwidth is similar to ARCHER. The increase in
    performance is due to the stronger floating-point performance with increased vector lengths and more cores.
-   Tesseract performance is worse than Cirrus even though it has the highest per-core StarSTREAM value. The lower number of
    cores per node reduce the floating point performance of a Tesseract node. The number of cores influences the floating
    point performance more than the increased vector length available on the Xeon Skylake Silver processors on Tesseract.
-   Although Isambard has the most cores per node and per-core memory bandwidth higher than Cirrus, the Isambard Arm64 node
    still has a lower floating point performance than the all the Intel Xeon nodes (apart from ARCHER). This manifests 
    as a lower CASTEP performance than all of the Intel Xeon nodes (apart from ARCHER).
-   Peta4-Skylake shows the best overall performance for this benchmark as nodes on this system have the highest overall 
    floating-point performance and high memory bandwidth per core.

<a id="osbli"></a>
### 3.2 OpenSBLI

[OpenSBLI](https://opensbli.github.io/) is a high-level framework for finite-difference based models, particularly for CFD simulations. It uses a Python-based Domain Specific Language (DSL) which can then generate C++ source code with (optionally) OpenMP, CUDA, OpenCL or OpenACC components for a variety of computer architectures (e.g. CPU, GPGPU).

The OpenSBLI 512^3, Taylor-Green vortex benchmark was supplied by the UK Turbulence Consortium. We expect this benchmark to be bound primarily by memory bandwidth. This is a strong scaling benchmark.

Details of the compile options, source code for the benchmark, the full output data and analysis scripts are available on GitHub at:

-   <https://github.com/hpc-uk/archer-benchmarks/tree/master/apps/OpenSBLI>

Although OpenSBLI does allow the use of GPU accelerators we found that, in practice, the memory available on the GPU 
accelerators was too small to be allow the bechmark case to run successfully on small node counts. We are investigating
if using a larger number of GPU accelerators in parallel will allow us to run the benchmark.

[Table 7](#tab7) shows the single-node performance for the benchmark on the different systems.

<a id="tab7"></a>Table 7: Single node performance comparison for OpenSBLI 512^3, Taylor-Green vortex benchmark run for
1000 iterations.

| System        | Performance (iter/s) | Performance relative to ARCHER node | Notes        |
|---------------|---------------------:|------------------------------------:|--------------|
| Isambard      | 0.178                | 1.777                               | 64 MPI tasks |
| Peta4-Skylake | 0.170                | 1.700                               | 32 MPI tasks |
| ARCHER        | 0.100                | 1.000                               | 24 MPI tasks |
| Cirrus        | 0.097                | 0.970                               | 36 MPI tasks |
| Tesseract     | 0.097                | 0.970                               | 24 MPI tasks |

The picture here is different to that for CASTEP, with the performance grouped into two distinct categories: the higher performance 
categroy includes the Isambard Marvell ThunderX2 Arm64 nodes and the Peta4-Skylake Intel Xeon Skylake Gold nodes; the lower
performance category includes the ARCHER Intel Xeon Ivy Bridge nodes, the Cirrus Intel Xeon Broadwell nodes and the Tesseract
Intel Xeon Skylake Silver nodes. At first glance, it appears that node memory performance is the key metric in determining
the performance difference with the older Xeon processors, which have 4 memory channels, having lower performance than
the ThunderX2 Arm64 and Xeon Skylake processors, which have 8 and 6 memory channels respectively. The oddity in this 
analysis is the performance of the Tesseract system, which has Xeon Skylake Silver processors with 6 memory channels.
One difference between the Skylake Silver and Skylake Gold processors is the frequency of memory supported - the maximum 
memory speed on Skylake Silver (Tesseract) is 2400 MHz whereas for the Skylake Gold (Peta4-Skylake) it is 2666 MHz. This
difference could account for some of the difference in performance. Further investigation and profiling are needed to 
understand the origin of this discrepency. 

<a id="gromacs"></a>
### 3.3 GROMACS

[GROMACS](http://www.gromacs.org) is a classical molecular mechanics-based biomolecular simulation application written in C/C++ with MPI and OpenMP parallelism. It also supports GPGPU (implemented in CUDA) and Xeon Phi (Knights Landing variant) versions.

Details of the compile options, the full output data and analysis scripts are available on GitHub at:

-   <https://github.com/hpc-uk/archer-benchmarks/tree/master/apps/GROMACS>

We have used the 1400k atom benchmark desgined by the High End Consortium for Biomolecular Simulation (HEC BioSim). This is a strong scaling benchmark. Benchmark details are available at the repository link above.

The single-node performance results for the GROMACS benchmark run using the single precision version of GROMACS are shown in [Table 8](#tab8).

<a id="tab8"></a>Table 8: Single node performance comparison for GROMACS 1400k atom benchmark.

| System        | Performance (ns/day) | Performance relative to ARCHER node   | Notes                                              |
|---------------|---------------------:|--------------------------------------:|----------------------------------------------------|
| Wilkes2-GPU   | 2.744                | 2.257                                 | 4 MPI tasks, 3 OMP per task, 4 GPU                 |
| Peta4-Skylake | 2.082                | 1.712                                 | 32 MPI tasks, 1 OpenMP thread per task             |
| Cirrus        | 1.699                | 1.397                                 | 36 MPI tasks, 2 OpenMP threads per task, 2-way SMT |
| JADE          | 1.647                | 1.354                                 | 1 MPI task, 5 OpenMP thread per task, 1 GPU        |
| Isambard      | 1.471                | 1.210                                 | 128 tasks, 2 OpenMP threads per task, 4-way SMT    |
| Tesseract     | 1.323                | 1.080                                 | 24 tasks, 2 OpenMP threads per task, 2-way SMT     |
| ARCHER        | 1.216                | 1.000                                 | 24 tasks, 2 OpenMP threads per task, 2-way SMT     |

We expect GROMACS performance to be directly correlated to floating point performance of the resources used. [Table 9](#tab9) details
the theoretical single precision (SP) floating point performance for each of the systems used in our exercise.

<a id="tab9"></a>Table 9: Theoretical maximum floating point performance for different platforms. CPU FLOPS are computed as
(number of cores used) * (single precision FLOPS per cycle) * (frequency). See [Table 10](#tab10) for values used for the different
systems. GPU FLOPS are computed as (number of GPUs used) * (GPU single precision FLOPS reference value
[ref](https://www.nvidia.com/en-us/data-center/tesla-p100/)). 

| System        | Cores used | CPU SP GFLOPS | GPU used | GPU SP GFLOPS | Node SP GFLOPS | Node GFLOPS relative to ARCHER node |
|---------------|-----------:|--------------:|---------:|--------------:|---------------:|------------------------------------:|
| Wilkes2-GPU   | 12         | 885           | 4        | 37,200        | 38,085         | 36.649                              |
| Peta4-Skylake | 32         | 5,325         | 0        |               | 5,325          | 5.135                               |
| Cirrus        | 36         | 2,419         | 0        |               | 2,419          | 2.326                               |
| JADE          | 5          | 352.0         | 1        | 10,600        | 10,952         | 10.561                              |
| Isambard      | 64         | 2,253         | 0        |               | 2,253          | 2.172                               |
| Tesseract     | 24         | 1,613         | 0        |               | 1,613          | 1.555                               |
| ARCHER        | 24         | 1,037         | 0        |               | 1,037          | 1.000                               |

<a id="tab10"></a>Table 10: Processor charateristics used to compute CPU FLOPS.

| System        | SP FLOPS per cycle | Clock speed (GHz) | Single core SP GFLOPS |
|---------------|-------------------:|------------------:|----------------------:|
| Peta4-Skylake | 64                 | 2.6               | 166.4                 | 
| Cirrus        | 32                 | 2.1               | 67.2                  | 
| Isambard      | 16                 | 2.2               | 35.2                  |
| Tesseract     | 32                 | 2.1               | 67.2                  |
| ARCHER        | 16                 | 2.7               | 43.2                  |

Comparing the ordering of the theoretical floating-point performance to the ordering of GROMACS performance, we can see that the only
case where the theoretical performance ordering does not match the observed GROMACS performance is for the JADE system. The GROMACS
performance on JADE is much lower than expected and this seems specific to this system as the performance on Wilkes2-GPU is correctly
ordered. Further investigation is needed to understand the origin of this performance issue.

It is also interesting to compare the theoretical performance ratios (relative to an ARCHER node) in [Table 9](#tab9) to the
observed performance ratios in [Table 8](#tab8) (excluding JADE as the performance issues are currently not well understood).
In particular, it appears that as you add more and more performance to the
processor architectures - which is mostly in the form of SIMD, rather than cores or increased frequencies - it becomes more and
more difficult for the GROMACS benchmark to extract the full performance potential from the architecture. For example, considering
just the CPU only results, the Intel Xeon Skylake Gold processors on the Peta4-Skylake system provide over 5x the theoretical
floating performance of the Intel Xeon Ivy Bridge processors on the ARCHER system but this translates into 1.7x the performance
of this GROMACS benchmark compared to ARCHER. Similar effects are seen for the Marvell ThunderX2 processors on Isambard and
the Intel Xeon Broadwell processors on Cirrus. This discrepency is even larger for the GPU-accelerated nodes on the Wilkes2-GPU
system where there is a theoretical FLOPS increase of over 36x in the resources used but this leads to a GROMACS benchmark
performance increase of just 2.7x. Of course, these effects may be affected by the size of the benchmark, with a larger GROMACS
benchmark able to make better use of the additonal SIMD performance available. However, this benchmark has been chosen by the
biomolecular simulation research community to be representative of their use of HPC systems and so this performance comparison 
is of direct interest 

<a id="summary"></a>
## 4. Summary and Conclusions

We have run three different HPC application benchamrks on a number of different UK national HPC services with a variety of 
different processor architectures. In particular, we compared the single node performance of the applications across the different
HPC systems.

In general, we were able to broadly correlate the performance of the different applications to particular properties of the 
compute node architecture (such as floating point performance and memory bandwidth) but there we a number of exceptions
to these correlations that we plan to investigate further which we describe below.

### 4.1 CASTEP

CASTEP performance was generally correlated to floating point performance of the compute node. However, the Isambard
(Marvell ThunderX2 Arm64) system showed lower performance than would be expected from the ordering of floating point 
performance of the different nodes. This could be due to a number of factors, potentially including:

-   The fact that this was run on pre-general availability hardware.
-   Less mature compilers and performance libraries for the relatively new Arm64 HPC architecture.
-   The high core count on the Isambard nodes (64 cores per node) leading to more memory access contention.
-   Process and thread pinning not functioning as expected.

We have recently gained access to one of the [HPE Catalyst UK](https://news.hpe.com/academia-and-industry-collaborate-to-drive-uk-supercomputer-adoption/)
systems with the general availability version of the Marvell ThuderX2 Arm64 processors and will repeat the benchmark runs on this
system to explore the performance of CASTEP on Arm processors further.

### 4.2 OpenSBLI

As expected for a CFD application, OpenSBLI performance was seen to correlate with memory bandwidth available per
node where the systems with higher numbers of memory channels (Isambard and Peta4-Skylake) showing higher performance
than the older processors with lower memory channels (and hence bandwidth).

The exception to this correlation was the Tesseract system (with Intel Xeon Skylake Silver processors) which had a very
high observed memory bandwidth but OpenSBLI benchmark performance similar to the systems with lower memory bandwidths.
We plan to investigate this discrepency further using profiling tools on the different systems. 

Finally, we were unable to run the OpenSBLI benchmark on GPU-accelerated nodes due to issues with the memory capacity
on individual GPU accelerators. We plan to follow up this issue to get a better understanding of the memory requirements
of the benchmark.

### 4.3 GROMACS

The performance of the GROMACS benchmark was correlated with the floating point performance of the compute nodes. There
is an issue with the performance of the GROMACS benchmark on the JADE GPU-accelerated system that requires further 
investigation - the results on the Wilkes2-GPU system with the same GPU accelerators demonstrate that good performance
can be achieved on the hardware.

While the performance of the GROMACS benchmark was correlated with the order of increasing floating point performance of
the different compute node architectures, we also saw that the ratio of observed performance improvement did not match 
the ratio of increased theoretical maximum floating point performance. As the increasing floating point performance 
theoretically available on the different architectures is obtained mostly from increased SIMD, this difference in 
performance ratios suggests that the GROMACS benchmark is less able to exploit the additional SIMD capability as 
this is added to processors. We plan to investigate further if this is a function of the benchmark or the GROMACS
application.

<a id="acknowledgements"></a>
## 5. Acknowledgements

Thanks to all of the HPC systems involved in this study for providing access and resources to be able to run the benchmarks. 
Their explicit acknowledgement statements are included below.

This work used the ARCHER UK National Supercomputing Service (<http://www.archer.ac.uk>).

This work used the DiRAC Extreme Scaling UK National HPC Service at The University of Edinburgh (<http://www.dirac.ac.uk>).

This work used the Cirrus UK National Tier-2 HPC Service at EPCC (<http://www.cirrus.ac.uk>).

This work used the CSD3 UK National Tier-2 HPC Service at the University of Cambridge (<https://www.csd3.cam.ac.uk/services/csd3-platform>).

This work used the JADE UK National Tier-2 HPC Service at the University of Oxford (<http://www.jade.ac.uk>).

This work used the Isambard UK National Tier-2 HPC Service at GW4 (<http://www.gw4.ac.uk/isambard>).
