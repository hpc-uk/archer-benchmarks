# Intel MPI Benchmarks (IMB)

This benchmark is used to test the MPI (and, indirectly, interconnect) performance of the systems.

IMB was downloaded from:

* https://github.com/intel/mpi-benchmarks

The following benchmarks were run:

* PingPong
* Sendrecv
* Alltoall
* Alltoallv
* Allgather
* Allgatherv

## Analysis

Results are analysed in a series of Jupyter notebooks:

* [Alltoall performance analysis](analysis/IMB_Alltoall_compare.ipynb)
* [Alltoallv performance analysis](analysis/IMB_Alltoallv_compare.ipynb)
* [Allgather performance analysis](analysis/IMB_Allgather_compare.ipynb)
* [Allgatherv performance analysis](analysis/IMB_Allgatherv_compare.ipynb)
* [Sendrecv performance analysis](analysis/IMB_Sendrecv_compare.ipynb)
* [PingPong performance analysis](analysis/IMB_PingPong_compare.ipynb)

Parsing of the IMB output file is performed by functions defined in a custom Python
module:

* [IMB benchmark performance analysis Python functions](../../python-modules/synthanalysis/imb.py)

## Job scripts

* [ARCHER](run/ARCHER/)
* [Athena](run/Athena/)
* [Cirrus](run/Cirrus/)
* [Fulhame](run/Fulhame/)
* [Peta4-Skylake](run/Peta4-Skylake/)
* [Tesseract](run/Tesseract/)

## Full output data: 

* [ARCHER, Cray MPICH 7.7.4](results/ARCHER_CrayMPICH774/)
* [Athena, Intel MPI 18.2](results/Athena_IMPI182/)
* [Cirrus, Intel MPI 18.1](results/Cirrus_IMPI18/)
* [Cirrus, SGI/HPE MPT 2.18](results/Cirrus_MPT218/)
* [Fulhame, HPE MPT 2.20](results/Fulhame_HMPT220/)
* [Fulhame, MVAPICH2 2.3.1](results/Fulhame_MVAPICH231/)
* [Fulhame, OpenMPI 4.0.0](results/Fulhame_OMPI4/)
* [Isambard, Cray MPICH 7.7.6](results/Isambard_CrayMPICH776/)
* [Peta4-Skylake, Intel MLPI 19.3](results/Peta4-Skylake_IMPI193/)
* [Tesseract, Intel MPI 18.1](results/Tesseract_IMPI181/)

## Compilation details

### ARCHER, Cray MPICH 7.7.4

```
module load cdt/18.12
module swap PrgEnv-cray PrgEnv-gnu
export CC=cc
export CXX=CC
make -j8 clean
make -j8
```

Modules loaded:

```
- Package -----------------------------+- Versions -+- Last mod. ------
Currently Loaded Modulefiles:
modules/3.2.11.1                         default     2018/10/24 20:47:09
eswrap/1.3.3-1.020200.1280.0                         2019/02/05 17:43:14
switch/1.0-1.0502.60522.1.61.ari                     2015/09/01 23:15:38
gcc/7.3.0                                default     2018/01/27  3:05:40
craype-ivybridge                                     2019/03/18 11:43:39
craype-network-aries                                 2019/03/18 11:43:39
craype/2.5.16                            default     2019/03/18 11:43:39
pbs/12.2.401.141761                                  2013/09/20 15:22:44
cray-mpich/7.7.4                         default     2019/03/18 11:59:21
packages-archer                                      2013/10/31 13:55:07
bolt/0.6                                             2015/08/12  8:36:57
nano/2.2.6                                           2015/05/08  9:56:15
leave_time/1.3.0                                     2016/12/04 16:43:50
quickstart/1.0                                       2015/05/08  9:56:15
ack/2.14                                             2015/10/19 11:18:29
xalt/0.6.0                                           2016/03/25 13:01:01
openssl/1.1.0g_build1                                2018/03/05 12:42:32
curl/7.58.0_build1                                   2018/03/05 14:54:43
git/2.16.2_build1                                    2018/03/05 20:13:17
wget/1.19.4                                          2018/03/08 17:33:15
epcc-tools/8.1                                       2019/05/07 10:08:00
cdt/18.12                                            2019/03/18 12:00:38
cray-libsci/18.12.1                      default     2019/03/18 12:00:03
udreg/2.3.2-1.0502.10518.2.17.ari                    2015/08/25 21:54:42
ugni/6.0-1.0502.10863.8.29.ari                       2015/09/01 23:15:01
pmi/5.0.14                               default     2019/03/18 11:58:44
dmapp/7.0.1-1.0502.11080.8.76.ari                    2015/09/02 19:42:48
gni-headers/4.0-1.0502.10859.7.8.ari                 2015/08/25 21:49:07
xpmem/0.1-2.0502.64982.5.3.ari                       2015/08/25 21:51:53
dvs/2.5_0.9.0-1.0502.2188.1.116.ari                  2015/09/02 17:26:43
alps/5.2.4-2.0502.9774.31.11.ari                     2015/09/01 23:28:04
rca/1.0.0-2.0502.60530.1.62.ari                      2015/09/01 23:13:49
atp/2.1.3                                default     2019/03/18 12:00:44
PrgEnv-gnu/5.2.82                                    2015/09/02 22:03:47
```

### Athena, Intel MPI 18.2

```
export CC=mpiicc
export CXX=mpiicpc
make -j8 clean
make -j8
```

### Athena, Intel MPI 18.2

```
module load gcc/6.3.0/1
module load intel/compiler/64/2018.2.199
module load intel/mpi/64/2018.2.199  
export CC=mpiicc
export CXX=mpiicpc
make -j8 clean
make -j8
```

### Cirrus, Intel MPI 18.1

```
module load intel-compilers-18/18.0.5.274
module load intel-mpi-18/18.0.5.274
export CC=mpiicc
export CXX=mpiicpc
make -j8 clean
make -j8
```

### Cirrus, SGI/HPE MPT 2.18

```
module load gcc/6.3.0
module load mpt/2.18
export CC=mpicc
export CXX=mpicxx
make -j8 clean
make -j8
```

### Fulhame, HPE MPT 2.20

### Fulhame, MVAPICH2 2.3.1

### Fulhame, OpenMPI 4.0.0

```
module load Generic-AArch64/SUSE/12/gcc/8.2.0
module load mpi/openmpi/gnu-8.2/4.0.0_opt
export CC=mpicc
export CXX=mpiCC
make -j8 clean
make -j8
```
### Isambard, Cray MPICH 7.7.4

```
module swap PrgEnv-cray PrgEnv-gnu
export CC=cc
export CXX=CC
make -j8 clean
make -j8
```

Modules loaded:

```
- Package -----------------------------+- Versions -+- Last mod. ------
Currently Loaded Modulefiles:
modules/3.2.11.1                                     2018/10/25 16:09:44
alps/6.6.50-7.0.0.1_3.18__g962f7108.ari              2019/03/26 20:49:26
nodestat/2.3.85-7.0.0.1_3.12__gc6218bb.              2019/03/26 20:33:55
sdb/3.3.794-7.0.0.1_4.7__gfff82fd.ari                2019/03/26 20:58:15
udreg/2.3.2-7.0.0.1_4.10__g8175d3d.ari               2019/03/23  8:48:26
ugni/6.0.14.0-7.0.0.1_7.12__ge78e5b0.ar              2019/03/23  9:02:11
gni-headers/5.0.12.0-7.0.0.1_7.14__g3b1              2019/03/23  8:28:13
dmapp/7.1.1-7.0.0.1_4.18__g54dc2b7.ari               2019/03/26 20:57:37
xpmem/2.2.17-7.0.0.1_3.11__g7acee3a.ari              2019/03/23  9:37:55
llm/21.4.570-7.0.0.1_5.6__ge50c6aa.ari               2019/03/23  8:15:13
nodehealth/5.6.15-7.0.0.1_4.19__g3727db              2019/03/26 21:01:18
system-config/3.5.2956-7.0.0.1_3.9__g0e              2019/03/23 10:00:17
Base-opts/2.4.139-7.0.0.1_4.11__gbb799d              2019/03/23  8:53:41
craype-network-aries                                 2019/03/11 14:18:13
craype/2.5.18                                        2019/03/11 14:18:13
cray-mpich/7.7.6                                     2019/03/11 14:50:06
rca/2.2.20-7.0.0.1_4.19__g8e3fb5b.ari                2019/03/26 20:42:34
gcc/8.2.0                                            2018/10/24  1:03:47
cray-libsci/18.12.1                                  2019/03/11 14:49:52
pmi/5.0.14                                           2019/03/11 14:18:29
atp/2.1.3                                            2019/03/11 14:22:26
perftools-base/7.0.6                                 2019/03/11 14:22:35
PrgEnv-gnu/6.0.5                                     2019/03/11 14:18:35
```

### Peta4-Skylake, Intel MPI 19.3

```
module purge
module add dot slurm turbovnc vgl singularity 
module add rhel7/global 
module add intel/bundles/complib/2019.3
export CC=mpiicc
export CXX=mpiicpc
make -j8 clean
make -j8
```

### Tesseract, Intel MPI 18.1

```
module load intel-cc-18/18.1.163
module load intel-mpi-18/18.1.163
export CC=mpiicc
export CXX=mpiicpc
make -j8 clean
make -j8
```