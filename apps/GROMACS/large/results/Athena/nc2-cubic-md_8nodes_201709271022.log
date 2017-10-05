#!/bin/bash --login
#SBATCH --time=3:0:0
#SBATCH --job-name=GromacsBench
#SBATCH --partition=compute
#SBATCH --nodes=8
#SBATCH --ntasks-per-node=28
#SBATCH --account=a01

cat $0

MPI_LAUNCH=mpirun

NUM_NODES=8

BENCHDIR=/gpfs/home/lboro/aturner/benchmarks/ARCHER/GROMACS/GromacsARCHERBench_master

module load gromacs/2016.3
# module load gromacs/5.1.4/4

MDRUN="mdrun_mpi"
# MDRUN="gmx_mpi mdrun"


casename=nc2-cubic-md

INPUTDIR=$BENCHDIR/inputTPR
TPRFILE=nsteps800.tpr

WORKDIR=/gpfs/home/lboro/aturner/benchmarks/ARCHER/GROMACS/gromacs_scratch

#hardware specific settings
CHIPS_PER_NODE=2
CORES_PER_CHIP=14

#choose number of MPI tasks per chip
TASKS_PER_CHIP=14

#choose number of hyperthreads per core
HTHREADS_PER_CORE=1 

#number of OpenMP threads per task is calculated 
export OMP_NUM_THREADS=$[($CORES_PER_CHIP*$HTHREADS_PER_CORE)/$TASKS_PER_CHIP]

#total number of tasks is calculated
tasks=$[$NUM_NODES*$CHIPS_PER_NODE*$TASKS_PER_CHIP]

rm -rf $WORKDIR
mkdir -p $WORKDIR
cd $WORKDIR

cp $INPUTDIR/$TPRFILE .

date
${MPI_LAUNCH} -n $tasks -ppn  $[$CHIPS_PER_NODE*$TASKS_PER_CHIP] $MDRUN -s $TPRFILE -deffnm $casename -ntomp $OMP_NUM_THREADS
date

echo
echo $casename.log
echo "------------"
cat $casename.log


Wed Sep 27 10:22:56 BST 2017
                      :-) GROMACS - mdrun_mpi, 2016.3 (-:

                            GROMACS is written by:
     Emile Apol      Rossen Apostolov  Herman J.C. Berendsen    Par Bjelkmar   
 Aldert van Buuren   Rudi van Drunen     Anton Feenstra    Gerrit Groenhof  
 Christoph Junghans   Anca Hamuraru    Vincent Hindriksen Dimitrios Karkoulis
    Peter Kasson        Jiri Kraus      Carsten Kutzner      Per Larsson    
  Justin A. Lemkul   Magnus Lundborg   Pieter Meulenhoff    Erik Marklund   
   Teemu Murtola       Szilard Pall       Sander Pronk      Roland Schulz   
  Alexey Shvetsov     Michael Shirts     Alfons Sijbers     Peter Tieleman  
  Teemu Virolainen  Christian Wennberg    Maarten Wolf   
                           and the project leaders:
        Mark Abraham, Berk Hess, Erik Lindahl, and David van der Spoel

Copyright (c) 1991-2000, University of Groningen, The Netherlands.
Copyright (c) 2001-2017, The GROMACS development team at
Uppsala University, Stockholm University and
the Royal Institute of Technology, Sweden.
check out http://www.gromacs.org for more information.

GROMACS is free software; you can redistribute it and/or modify it
under the terms of the GNU Lesser General Public License
as published by the Free Software Foundation; either version 2.1
of the License, or (at your option) any later version.

GROMACS:      mdrun_mpi, version 2016.3
Executable:   /gpfs/home/lboro/aturner/software/GROMACS/2016.3-gcc6/bin/mdrun_mpi
Data prefix:  /gpfs/home/lboro/aturner/software/GROMACS/2016.3-gcc6
Working dir:  /gpfs/home/lboro/aturner/benchmarks/ARCHER/GROMACS/gromacs_scratch
Command line:
  mdrun_mpi -s nsteps800.tpr -deffnm nc2-cubic-md -ntomp 1


Running on 8 nodes with total 224 cores, 224 logical cores
  Cores per node:           28
  Logical cores per node:   28
Hardware detected on host node0502 (the node of MPI rank 0):
  CPU info:
    Vendor: Intel
    Brand:  Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz
    SIMD instructions most likely to fit this hardware: AVX2_256
    SIMD instructions selected at GROMACS compile time: AVX2_256

  Hardware topology: Basic

Reading file nsteps800.tpr, VERSION 5.1 (single precision)
Note: file tpx version 103, software tpx version 110
Changing nstlist from 10 to 25, rlist from 1.4 to 1.436

The number of OpenMP threads was set by environment variable OMP_NUM_THREADS to 1 (and the command-line setting agreed with that)

Will use 192 particle-particle and 32 PME only ranks
This is a guess, check the performance at the end of the log file
Using 224 MPI processes
Using 1 OpenMP thread per MPI process


Non-default thread affinity set probably by the OpenMP library,
disabling internal thread affinity
starting mdrun 'Protein in water'
800 steps,      1.6 ps.

Writing final coordinates.

 Average load imbalance: 4.1 %
 Part of the total run time spent waiting due to load imbalance: 2.3 %
 Average PME mesh/force load: 1.390
 Part of the total run time spent waiting due to PP/PME imbalance: 20.9 %

NOTE: 20.9 % performance was lost because the PME ranks
      had more work to do than the PP ranks.
      You might want to increase the number of PME ranks
      or increase the cut-off and the grid spacing.


NOTE: 12 % of the run time was spent communicating energies,
      you might want to use the -gcom option of mdrun


               Core t (s)   Wall t (s)        (%)
       Time:   147140.672      656.878    22400.0
                 (ns/day)    (hour/ns)
Performance:        0.211      113.899

GROMACS reminds you: "Exactly" (Pulp Fiction)

Wed Sep 27 10:34:42 BST 2017

nc2-cubic-md.log
------------
Log file opened on Wed Sep 27 10:22:57 2017
Host: node0502  pid: 10956  rank ID: 0  number of ranks:  224
                      :-) GROMACS - mdrun_mpi, 2016.3 (-:

                            GROMACS is written by:
     Emile Apol      Rossen Apostolov  Herman J.C. Berendsen    Par Bjelkmar   
 Aldert van Buuren   Rudi van Drunen     Anton Feenstra    Gerrit Groenhof  
 Christoph Junghans   Anca Hamuraru    Vincent Hindriksen Dimitrios Karkoulis
    Peter Kasson        Jiri Kraus      Carsten Kutzner      Per Larsson    
  Justin A. Lemkul   Magnus Lundborg   Pieter Meulenhoff    Erik Marklund   
   Teemu Murtola       Szilard Pall       Sander Pronk      Roland Schulz   
  Alexey Shvetsov     Michael Shirts     Alfons Sijbers     Peter Tieleman  
  Teemu Virolainen  Christian Wennberg    Maarten Wolf   
                           and the project leaders:
        Mark Abraham, Berk Hess, Erik Lindahl, and David van der Spoel

Copyright (c) 1991-2000, University of Groningen, The Netherlands.
Copyright (c) 2001-2017, The GROMACS development team at
Uppsala University, Stockholm University and
the Royal Institute of Technology, Sweden.
check out http://www.gromacs.org for more information.

GROMACS is free software; you can redistribute it and/or modify it
under the terms of the GNU Lesser General Public License
as published by the Free Software Foundation; either version 2.1
of the License, or (at your option) any later version.

GROMACS:      mdrun_mpi, version 2016.3
Executable:   /gpfs/home/lboro/aturner/software/GROMACS/2016.3-gcc6/bin/mdrun_mpi
Data prefix:  /gpfs/home/lboro/aturner/software/GROMACS/2016.3-gcc6
Working dir:  /gpfs/home/lboro/aturner/benchmarks/ARCHER/GROMACS/gromacs_scratch
Command line:
  mdrun_mpi -s nsteps800.tpr -deffnm nc2-cubic-md -ntomp 1

GROMACS version:    2016.3
Precision:          single
Memory model:       64 bit
MPI library:        MPI
OpenMP support:     enabled (GMX_OPENMP_MAX_THREADS = 32)
GPU support:        disabled
SIMD instructions:  AVX2_256
FFT library:        fftw-3.3.5
RDTSCP usage:       enabled
TNG support:        enabled
Hwloc support:      disabled
Tracing support:    disabled
Built on:           Thu Sep 21 07:28:57 UTC 2017
Built by:           aturner@login02 [CMAKE]
Build OS/arch:      Linux 3.10.0-514.26.2.el7.x86_64 x86_64
Build CPU vendor:   Intel
Build CPU brand:    Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz
Build CPU family:   6   Model: 79   Stepping: 1
Build CPU features: aes apic avx avx2 clfsh cmov cx8 cx16 f16c fma hle htt lahf mmx msr nonstop_tsc pcid pclmuldq pdcm pdpe1gb popcnt pse rdrnd rdtscp rtm sse2 sse3 sse4.1 sse4.2 ssse3 tdt x2apic
C compiler:         /trinity/shared/apps/cv-standard/intel/2017.2.174/compilers_and_libraries_2017.2.174/linux/mpi/intel64/bin/mpicc GNU 6.3.0
C compiler flags:    -march=core-avx2     -O3 -DNDEBUG -funroll-all-loops -fexcess-precision=fast  
C++ compiler:       /trinity/shared/apps/cv-standard/intel/2017.2.174/compilers_and_libraries_2017.2.174/linux/mpi/intel64/bin/mpicxx GNU 6.3.0
C++ compiler flags:  -march=core-avx2    -std=c++0x   -O3 -DNDEBUG -funroll-all-loops -fexcess-precision=fast  

Note: 56 CPUs configured, but only 28 were detected to be online.
      X86 Hyperthreading is likely disabled; enable it for better performance.

Running on 8 nodes with total 224 cores, 224 logical cores
  Cores per node:           28
  Logical cores per node:   28
Hardware detected on host node0502 (the node of MPI rank 0):
  CPU info:
    Vendor: Intel
    Brand:  Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz
    Family: 6   Model: 79   Stepping: 1
    Features: aes apic avx avx2 clfsh cmov cx8 cx16 f16c fma hle htt lahf mmx msr nonstop_tsc pcid pclmuldq pdcm pdpe1gb popcnt pse rdrnd rdtscp rtm sse2 sse3 sse4.1 sse4.2 ssse3 tdt x2apic
    SIMD instructions most likely to fit this hardware: AVX2_256
    SIMD instructions selected at GROMACS compile time: AVX2_256

  Hardware topology: Basic
    Sockets, cores, and logical processors:
      Socket  0: [   0] [   1] [   2] [   3] [   4] [   5] [   6] [   7] [   8] [   9] [  10] [  11] [  12] [  13]
      Socket  1: [  14] [  15] [  16] [  17] [  18] [  19] [  20] [  21] [  22] [  23] [  24] [  25] [  26] [  27]


++++ PLEASE READ AND CITE THE FOLLOWING REFERENCE ++++
M. J. Abraham, T. Murtola, R. Schulz, S. Páll, J. C. Smith, B. Hess, E.
Lindahl
GROMACS: High performance molecular simulations through multi-level
parallelism from laptops to supercomputers
SoftwareX 1 (2015) pp. 19-25
-------- -------- --- Thank You --- -------- --------


++++ PLEASE READ AND CITE THE FOLLOWING REFERENCE ++++
S. Páll, M. J. Abraham, C. Kutzner, B. Hess, E. Lindahl
Tackling Exascale Software Challenges in Molecular Dynamics Simulations with
GROMACS
In S. Markidis & E. Laure (Eds.), Solving Software Challenges for Exascale 8759 (2015) pp. 3-27
-------- -------- --- Thank You --- -------- --------


++++ PLEASE READ AND CITE THE FOLLOWING REFERENCE ++++
S. Pronk, S. Páll, R. Schulz, P. Larsson, P. Bjelkmar, R. Apostolov, M. R.
Shirts, J. C. Smith, P. M. Kasson, D. van der Spoel, B. Hess, and E. Lindahl
GROMACS 4.5: a high-throughput and highly parallel open source molecular
simulation toolkit
Bioinformatics 29 (2013) pp. 845-54
-------- -------- --- Thank You --- -------- --------


++++ PLEASE READ AND CITE THE FOLLOWING REFERENCE ++++
B. Hess and C. Kutzner and D. van der Spoel and E. Lindahl
GROMACS 4: Algorithms for highly efficient, load-balanced, and scalable
molecular simulation
J. Chem. Theory Comput. 4 (2008) pp. 435-447
-------- -------- --- Thank You --- -------- --------


++++ PLEASE READ AND CITE THE FOLLOWING REFERENCE ++++
D. van der Spoel, E. Lindahl, B. Hess, G. Groenhof, A. E. Mark and H. J. C.
Berendsen
GROMACS: Fast, Flexible and Free
J. Comp. Chem. 26 (2005) pp. 1701-1719
-------- -------- --- Thank You --- -------- --------


++++ PLEASE READ AND CITE THE FOLLOWING REFERENCE ++++
E. Lindahl and B. Hess and D. van der Spoel
GROMACS 3.0: A package for molecular simulation and trajectory analysis
J. Mol. Mod. 7 (2001) pp. 306-317
-------- -------- --- Thank You --- -------- --------


++++ PLEASE READ AND CITE THE FOLLOWING REFERENCE ++++
H. J. C. Berendsen, D. van der Spoel and R. van Drunen
GROMACS: A message-passing parallel molecular dynamics implementation
Comp. Phys. Comm. 91 (1995) pp. 43-56
-------- -------- --- Thank You --- -------- --------

Changing nstlist from 10 to 25, rlist from 1.4 to 1.436

Input Parameters:
   integrator                     = md
   tinit                          = 0
   dt                             = 0.002
   nsteps                         = 800
   init-step                      = 0
   simulation-part                = 1
   comm-mode                      = Linear
   nstcomm                        = 100
   bd-fric                        = 0
   ld-seed                        = 3003051368
   emtol                          = 10
   emstep                         = 0.01
   niter                          = 20
   fcstep                         = 0
   nstcgsteep                     = 1000
   nbfgscorr                      = 10
   rtpi                           = 0.05
   nstxout                        = 0
   nstvout                        = 0
   nstfout                        = 0
   nstlog                         = 5000
   nstcalcenergy                  = 100
   nstenergy                      = 50000
   nstxout-compressed             = 50000
   compressed-x-precision         = 1000
   cutoff-scheme                  = Verlet
   nstlist                        = 25
   ns-type                        = Grid
   pbc                            = xyz
   periodic-molecules             = false
   verlet-buffer-tolerance        = 0.005
   rlist                          = 1.436
   coulombtype                    = PME
   coulomb-modifier               = Potential-shift
   rcoulomb-switch                = 0
   rcoulomb                       = 1.4
   epsilon-r                      = 1
   epsilon-rf                     = inf
   vdw-type                       = Cut-off
   vdw-modifier                   = Potential-shift
   rvdw-switch                    = 0
   rvdw                           = 1.4
   DispCorr                       = EnerPres
   table-extension                = 1
   fourierspacing                 = 0.12
   fourier-nx                     = 640
   fourier-ny                     = 640
   fourier-nz                     = 640
   pme-order                      = 4
   ewald-rtol                     = 1e-05
   ewald-rtol-lj                  = 0.001
   lj-pme-comb-rule               = Geometric
   ewald-geometry                 = 0
   epsilon-surface                = 0
   implicit-solvent               = No
   gb-algorithm                   = Still
   nstgbradii                     = 1
   rgbradii                       = 1
   gb-epsilon-solvent             = 80
   gb-saltconc                    = 0
   gb-obc-alpha                   = 1
   gb-obc-beta                    = 0.8
   gb-obc-gamma                   = 4.85
   gb-dielectric-offset           = 0.009
   sa-algorithm                   = Ace-approximation
   sa-surface-tension             = 2.05016
   tcoupl                         = V-rescale
   nsttcouple                     = 10
   nh-chain-length                = 0
   print-nose-hoover-chain-variables = false
   pcoupl                         = Berendsen
   pcoupltype                     = Isotropic
   nstpcouple                     = 10
   tau-p                          = 1
   compressibility (3x3):
      compressibility[    0]={ 4.50000e-05,  0.00000e+00,  0.00000e+00}
      compressibility[    1]={ 0.00000e+00,  4.50000e-05,  0.00000e+00}
      compressibility[    2]={ 0.00000e+00,  0.00000e+00,  4.50000e-05}
   ref-p (3x3):
      ref-p[    0]={ 1.00000e+00,  0.00000e+00,  0.00000e+00}
      ref-p[    1]={ 0.00000e+00,  1.00000e+00,  0.00000e+00}
      ref-p[    2]={ 0.00000e+00,  0.00000e+00,  1.00000e+00}
   refcoord-scaling               = No
   posres-com (3):
      posres-com[0]= 0.00000e+00
      posres-com[1]= 0.00000e+00
      posres-com[2]= 0.00000e+00
   posres-comB (3):
      posres-comB[0]= 0.00000e+00
      posres-comB[1]= 0.00000e+00
      posres-comB[2]= 0.00000e+00
   QMMM                           = false
   QMconstraints                  = 0
   QMMMscheme                     = 0
   MMChargeScaleFactor            = 1
qm-opts:
   ngQM                           = 0
   constraint-algorithm           = Lincs
   continuation                   = false
   Shake-SOR                      = false
   shake-tol                      = 0.0001
   lincs-order                    = 4
   lincs-iter                     = 1
   lincs-warnangle                = 30
   nwall                          = 0
   wall-type                      = 9-3
   wall-r-linpot                  = -1
   wall-atomtype[0]               = -1
   wall-atomtype[1]               = -1
   wall-density[0]                = 0
   wall-density[1]                = 0
   wall-ewald-zfac                = 3
   pull                           = false
   rotation                       = false
   interactiveMD                  = false
   disre                          = No
   disre-weighting                = Conservative
   disre-mixed                    = false
   dr-fc                          = 1000
   dr-tau                         = 0
   nstdisreout                    = 100
   orire-fc                       = 0
   orire-tau                      = 0
   nstorireout                    = 100
   free-energy                    = no
   cos-acceleration               = 0
   deform (3x3):
      deform[    0]={ 0.00000e+00,  0.00000e+00,  0.00000e+00}
      deform[    1]={ 0.00000e+00,  0.00000e+00,  0.00000e+00}
      deform[    2]={ 0.00000e+00,  0.00000e+00,  0.00000e+00}
   simulated-tempering            = false
   E-x:
      n = 0
   E-xt:
      n = 0
   E-y:
      n = 0
   E-yt:
      n = 0
   E-z:
      n = 0
   E-zt:
      n = 0
   swapcoords                     = no
   userint1                       = 0
   userint2                       = 0
   userint3                       = 0
   userint4                       = 0
   userreal1                      = 0
   userreal2                      = 0
   userreal3                      = 0
   userreal4                      = 0
grpopts:
   nrdf:  2.92671e+06  8.10528e+07
   ref-t:         310         310
   tau-t:         0.1         0.1
annealing:          No          No
annealing-npoints:           0           0
   acc:	           0           0           0
   nfreeze:           N           N           N
   energygrp-flags[  0]: 0 0
   energygrp-flags[  1]: 0 0


Initializing Domain Decomposition on 224 ranks
Dynamic load balancing: auto
Initial maximum inter charge-group distances:
    two-body bonded interactions: 0.458 nm, LJ-14, atoms 784370 785191
  multi-body bonded interactions: 0.458 nm, Proper Dih., atoms 784370 785191
Minimum cell size due to bonded interactions: 0.504 nm
Maximum distance for 5 constraints, at 120 deg. angles, all-trans: 0.871 nm
Estimated maximum distance required for P-LINCS: 0.871 nm
This distance will limit the DD cell size, you can override this with -rcon
Guess for relative PME load: 0.15
Will use 192 particle-particle and 32 PME only ranks
This is a guess, check the performance at the end of the log file
Using 32 separate PME ranks, as guessed by mdrun
Scaling the initial minimum size with 1/0.8 (option -dds) = 1.25
Optimizing the DD grid for 192 cells with a minimum initial size of 1.089 nm
The maximum allowed number of cells is: X 69 Y 69 Z 69
Domain decomposition grid 32 x 3 x 2, separate PME ranks 32
PME domain decomposition: 32 x 1 x 1
Interleaving PP and PME ranks
This rank does only particle-particle work.

Domain decomposition rank 0, coordinates 0 0 0

The initial number of communication pulses is: X 1 Y 1 Z 1
The initial domain decomposition cell size is: X 2.35 nm Y 25.09 nm Z 37.63 nm

The maximum allowed distance for charge groups involved in interactions is:
                 non-bonded interactions           1.436 nm
(the following are initial values, they could change due to box deformation)
            two-body bonded interactions  (-rdd)   1.436 nm
          multi-body bonded interactions  (-rdd)   1.436 nm
  atoms separated by up to 5 constraints  (-rcon)  2.352 nm

When dynamic load balancing gets turned on, these settings will change to:
The maximum number of communication pulses is: X 1 Y 1 Z 1
The minimum size for domain decomposition cells is 1.436 nm
The requested allowed shrink of DD cells (option -dds) is: 0.80
The allowed shrink of domain decomposition cells is: X 0.61 Y 0.06 Z 0.04
The maximum allowed distance for charge groups involved in interactions is:
                 non-bonded interactions           1.436 nm
            two-body bonded interactions  (-rdd)   1.436 nm
          multi-body bonded interactions  (-rdd)   1.436 nm
  atoms separated by up to 5 constraints  (-rcon)  1.436 nm

Using two step summing over 8 groups of on average 24.0 ranks

Using 224 MPI processes
Using 1 OpenMP thread per MPI process

Will do PME sum in reciprocal space for electrostatic interactions.

++++ PLEASE READ AND CITE THE FOLLOWING REFERENCE ++++
U. Essmann, L. Perera, M. L. Berkowitz, T. Darden, H. Lee and L. G. Pedersen 
A smooth particle mesh Ewald method
J. Chem. Phys. 103 (1995) pp. 8577-8592
-------- -------- --- Thank You --- -------- --------

Will do ordinary reciprocal space Ewald sum.
Using a Gaussian width (1/beta) of 0.448228 nm for Ewald
Cut-off's:   NS: 1.436   Coulomb: 1.4   LJ: 1.4
Long Range LJ corr.: <C6> 2.9451e-04
System total charge: 0.001
Generated table with 1217 data points for Ewald.
Tabscale = 500 points/nm
Generated table with 1217 data points for LJ6.
Tabscale = 500 points/nm
Generated table with 1217 data points for LJ12.
Tabscale = 500 points/nm
Generated table with 1217 data points for 1-4 COUL.
Tabscale = 500 points/nm
Generated table with 1217 data points for 1-4 LJ6.
Tabscale = 500 points/nm
Generated table with 1217 data points for 1-4 LJ12.
Tabscale = 500 points/nm
Potential shift: LJ r^-12: -1.764e-02 r^-6: -1.328e-01, Ewald -1.000e-05
Initialized non-bonded Ewald correction tables, spacing: 1.10e-03 size: 1270


Using SIMD 4x8 non-bonded kernels

Using Lorentz-Berthelot Lennard-Jones combination rule

Removing pbc first time

Non-default thread affinity set probably by the OpenMP library,
disabling internal thread affinity

Initializing Parallel LINear Constraint Solver

++++ PLEASE READ AND CITE THE FOLLOWING REFERENCE ++++
B. Hess
P-LINCS: A Parallel Linear Constraint Solver for molecular simulation
J. Chem. Theory Comput. 4 (2008) pp. 116-122
-------- -------- --- Thank You --- -------- --------

The number of constraints is 1473120
There are inter charge-group constraints,
will communicate selected coordinates each lincs iteration

++++ PLEASE READ AND CITE THE FOLLOWING REFERENCE ++++
S. Miyamoto and P. A. Kollman
SETTLE: An Analytical Version of the SHAKE and RATTLE Algorithms for Rigid
Water Models
J. Comp. Chem. 13 (1992) pp. 952-962
-------- -------- --- Thank You --- -------- --------


Linking all bonded interactions to atoms

Intra-simulation communication will occur every 5 steps.
Center of mass motion removal mode is Linear
We have the following groups for center of mass motion removal:
  0:  rest

++++ PLEASE READ AND CITE THE FOLLOWING REFERENCE ++++
G. Bussi, D. Donadio and M. Parrinello
Canonical sampling through velocity rescaling
J. Chem. Phys. 126 (2007) pp. 014101
-------- -------- --- Thank You --- -------- --------

There are: 41953021 Atoms
Atom distribution over 192 domains: av 218505 stddev 1183 min 216039 max 221496

Constraining the starting coordinates (step 0)

Constraining the coordinates at t0-dt (step 0)
RMS relative constraint deviation after constraining: 0.00e+00
Initial temperature: 462.487 K

Started mdrun on rank 0 Wed Sep 27 10:23:44 2017
           Step           Time
              0        0.00000

   Energies (kJ/mol)
          Angle    Proper Dih.  Improper Dih.          LJ-14     Coulomb-14
    9.70061e+05    3.47595e+06    3.76448e+04    1.22264e+06    2.58018e+07
        LJ (SR)  Disper. corr.   Coulomb (SR)   Coul. recip.      Potential
    1.25713e+08   -1.85510e+06   -8.63649e+08    6.81720e+05   -7.07601e+08
    Kinetic En.   Total Energy    Temperature Pres. DC (bar) Pressure (bar)
    1.61477e+08   -5.46124e+08    4.62524e+02   -7.22823e+01   -1.41634e+03
   Constr. rmsd
    6.55084e-05

DD  step 24 load imb.: force  3.3%  pme mesh/force 1.632

step  100: timed with pme grid 640 640 640, coulomb cutoff 1.400: 39781.1 M-cycles
step  150: timed with pme grid 576 576 576, coulomb cutoff 1.524: 32268.7 M-cycles
step  200: timed with pme grid 512 512 512, coulomb cutoff 1.715: 41589.9 M-cycles
step  250: timed with pme grid 560 560 560, coulomb cutoff 1.568: 33952.9 M-cycles
step  300: timed with pme grid 576 576 576, coulomb cutoff 1.524: 31760.6 M-cycles
step  350: timed with pme grid 600 600 600, coulomb cutoff 1.463: 34344.5 M-cycles
              optimal pme grid 576 576 576, coulomb cutoff 1.524
DD  step 799 load imb.: force  5.6%  pme mesh/force 0.986

           Step           Time
            800        1.60000

Writing checkpoint, step 800 at Wed Sep 27 10:32:58 2017


   Energies (kJ/mol)
          Angle    Proper Dih.  Improper Dih.          LJ-14     Coulomb-14
    2.95416e+06    3.85824e+06    1.79258e+05    1.59295e+06    2.60297e+07
        LJ (SR)  Disper. corr.   Coulomb (SR)   Coul. recip.      Potential
    7.96918e+07   -1.85212e+06   -6.86204e+08    9.82750e+05   -5.72768e+08
    Kinetic En.   Total Energy    Temperature Pres. DC (bar) Pressure (bar)
    1.07852e+08   -4.64916e+08    3.08922e+02   -7.20504e+01   -5.48000e+00
   Constr. rmsd
    3.35873e-05

	<======  ###############  ==>
	<====  A V E R A G E S  ====>
	<==  ###############  ======>

	Statistics over 801 steps using 9 frames

   Energies (kJ/mol)
          Angle    Proper Dih.  Improper Dih.          LJ-14     Coulomb-14
    2.69929e+06    3.80911e+06    1.58893e+05    1.54304e+06    2.59954e+07
        LJ (SR)  Disper. corr.   Coulomb (SR)   Coul. recip.      Potential
    8.75467e+07   -1.85252e+06   -7.15655e+08    9.17327e+05   -5.94838e+08
    Kinetic En.   Total Energy    Temperature Pres. DC (bar) Pressure (bar)
    1.09722e+08   -4.85116e+08    3.14280e+02   -7.20816e+01   -2.61010e+02
   Constr. rmsd
    0.00000e+00

          Box-X          Box-Y          Box-Z
    7.52997e+01    7.52997e+01    7.52997e+01

   Total Virial (kJ/mol)
    3.99274e+07    2.91646e+04    3.21682e+04
    3.31298e+04    3.99087e+07   -1.95771e+04
    3.34755e+04   -1.80676e+04    3.99531e+07

   Pressure (bar)
   -2.60942e+02   -2.51519e+00   -2.44122e+00
   -2.82411e+00   -2.59857e+02    1.34723e+00
   -2.54256e+00    1.23223e+00   -2.62231e+02

  Epot (kJ/mol)        Coul-SR          LJ-SR        Coul-14          LJ-14   
Protein-Protein   -3.36570e+07   -2.84215e+06    2.59954e+07    1.54304e+06
Protein-Water_and_ions   -8.87700e+06   -8.91292e+05    0.00000e+00    0.00000e+00
Water_and_ions-Water_and_ions   -6.73121e+08    9.12802e+07    0.00000e+00    0.00000e+00

      T-ProteinT-Water_and_ions
    3.20863e+02    3.14042e+02


       P P   -   P M E   L O A D   B A L A N C I N G

 PP/PME load balancing changed the cut-off and PME settings:
           particle-particle                    PME
            rcoulomb  rlist            grid      spacing   1/beta
   initial  1.400 nm  1.436 nm     640 640 640   0.118 nm  0.448 nm
   final    1.524 nm  1.560 nm     576 576 576   0.131 nm  0.488 nm
 cost-ratio           1.28             0.73
 (note that these numbers concern only part of the total PP and PME load)


	M E G A - F L O P S   A C C O U N T I N G

 NB=Group-cutoff nonbonded kernels    NxN=N-by-N cluster Verlet kernels
 RF=Reaction-Field  VdW=Van der Waals  QSTab=quadratic-spline table
 W3=SPC/TIP3p  W4=TIP4p (single or pairs)
 V&F=Potential and force  V=Potential only  F=Force only

 Computing:                               M-Number         M-Flops  % Flops
-----------------------------------------------------------------------------
 Pair Search distance check         1508491.308496    13576421.776     0.5
 NxN Ewald Elec. + LJ [F]          22949522.589424  1514668490.902    52.9
 NxN Ewald Elec. + LJ [V&F]          255531.557488    27341876.651     1.0
 NxN Ewald Elec. [F]               20670459.230800  1260898013.079    44.0
 NxN Ewald Elec. [V&F]               230224.172816    19338830.517     0.7
 1,4 nonbonded interactions            3087.734850      277896.136     0.0
 Calc Weights                        100813.109463     3629271.941     0.1
 Spread Q Bspline                   2150679.668544     4301359.337     0.2
 Gather F Bspline                   2150679.668544    12904078.011     0.5
 Solve PME                              270.555776       17315.570     0.0
 Reset In Box                          1384.449693        4153.349     0.0
 CG-CoM                                1426.402714        4279.208     0.0
 Angles                                2161.786860      363180.192     0.0
 Propers                               3308.979060      757756.205     0.0
 Impropers                              198.896310       41370.432     0.0
 Virial                                3398.894541       61180.102     0.0
 Stop-CM                                419.530210        4195.302     0.0
 P-Coupling                            3356.241680       20137.450     0.0
 Calc-Ekin                            13508.872762      364739.565     0.0
 Lincs                                 1507.466680       90448.001     0.0
 Lincs-Mat                            32954.838840      131819.355     0.0
 Constraint-V                         36779.896224      294239.170     0.0
 Constraint-Vir                        3562.622796       85502.947     0.0
 Settle                               11270.281306     3640300.862     0.1
-----------------------------------------------------------------------------
 Total                                              2862816856.060   100.0
-----------------------------------------------------------------------------


    D O M A I N   D E C O M P O S I T I O N   S T A T I S T I C S

 av. #atoms communicated per step for force:  2 x 34349207.5
 av. #atoms communicated per step for LINCS:  2 x 2115935.2

 Average load imbalance: 4.1 %
 Part of the total run time spent waiting due to load imbalance: 2.3 %
 Average PME mesh/force load: 1.390
 Part of the total run time spent waiting due to PP/PME imbalance: 20.9 %

NOTE: 20.9 % performance was lost because the PME ranks
      had more work to do than the PP ranks.
      You might want to increase the number of PME ranks
      or increase the cut-off and the grid spacing.


     R E A L   C Y C L E   A N D   T I M E   A C C O U N T I N G

On 192 MPI ranks doing PP, and
on 32 MPI ranks doing PME

 Computing:          Num   Num      Call    Wall time         Giga-Cycles
                     Ranks Threads  Count      (s)         total sum    %
-----------------------------------------------------------------------------
 Domain decomp.       192    1         33      19.430       8932.535   2.5
 DD comm. load        192    1          3       0.001          0.395   0.0
 Send X to PME        192    1        801       2.123        975.884   0.3
 Neighbor search      192    1         33      22.300      10251.900   2.9
 Comm. coord.         192    1        768       4.254       1955.824   0.6
 Force                192    1        801     427.603     196582.880  55.8
 Wait + Comm. F       192    1        801      13.471       6193.257   1.8
 PME mesh *            32    1        801     455.533      34903.918   9.9
 PME wait for PP *                            201.196      15416.036   4.4
 Wait + Recv. PME F   192    1        801      38.196      17559.997   5.0
 NB X/F buffer ops.   192    1       2337       2.865       1317.085   0.4
 Write traj.          192    1          2       2.232       1025.998   0.3
 Update               192    1        801       3.270       1503.168   0.4
 Constraints          192    1        801      26.456      12162.718   3.5
 Comm. energies       192    1        161      93.739      43094.891  12.2
 Rest                                           0.939        431.732   0.1
-----------------------------------------------------------------------------
 Total                                        656.878     352319.642 100.0
-----------------------------------------------------------------------------
(*) Note that with separate PME ranks, the walltime column actually sums to
    twice the total reported, but the cycle count total and % are correct.
-----------------------------------------------------------------------------
 Breakdown of PME mesh computation
-----------------------------------------------------------------------------
 PME redist. X/F       32    1       1602      20.732       1588.513   0.5
 PME spread/gather     32    1       1602     162.350      12439.603   3.5
 PME 3D-FFT            32    1       1602     244.429      18728.674   5.3
 PME 3D-FFT Comm.      32    1       1602      19.657       1506.151   0.4
 PME solve Elec        32    1        801       8.359        640.480   0.2
-----------------------------------------------------------------------------

NOTE: 12 % of the run time was spent communicating energies,
      you might want to use the -gcom option of mdrun


               Core t (s)   Wall t (s)        (%)
       Time:   147140.672      656.878    22400.0
                 (ns/day)    (hour/ns)
Performance:        0.211      113.899
Finished mdrun on rank 0 Wed Sep 27 10:34:41 2017
