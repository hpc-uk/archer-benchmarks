CrayPat/X:  Version 6.4.6 Revision 7d0d87c  02/20/17 09:52:37

Number of PEs (MPI ranks):   768
                           
Numbers of PEs per Node:      24  PEs on each of  32  Nodes
                           
Numbers of Threads per PE:     1
                           
Number of Cores per Socket:   12

Execution start time:  Wed Nov 11 19:14:35 2020

System name and speed:  mom4  2701 MHz (approx)

Intel ivybridge CPU  Family:  6  Model: 62  Stepping:  4


Current path to data file:
  /work/z01/z01/aturner/benchmark/VASP/CdTe_Hybrid/vasp_ncl+pat+44280-4214s.ap2  (RTS)


Notes for table 1:

  Table option:
    -O samp_profile
  Options implied by table option:
    -d sa%@0.95,sa,imb_sa,imb_sa% -b gr,fu,pe=HIDE

  Options for related tables:
    -O samp_profile+src        -O profile_max         

  The Total value for Samp is the sum of the Group values.
  The Group value for Samp is the sum of the Function values.
  The Function value for Samp is the avg of the PE values.
    (To specify different aggregations, see: pat_help report options s1)

  This table shows only lines with Samp% > 0.95.
    (To set thresholds to zero, specify:  -T)

  Imbalance percentages are relative to a set of threads or PEs.
  Other percentages at each level are of the Total for the program.
    (For percentages relative to next level up, specify:
      -s percent=r[elative])

  To make the profile easier to interpret, some samples are attributed
  to a caller that is either a user defined function, or a library
  function called directly by a user defined function.  To disable this
  adjustment, and show functions actually sampled, use the -P option.
  
  The following groups were pruned due to thresholding:
    SYSCALL, IO, HEAP, PTHREAD, RT, MATH, STDIO, BLACS, SCALAPACK, FFTW,
    PBLAS, STRING
  
  Trace option suggestions have been generated into a separate file
  from the data in the next table.  You can examine the file, edit it
  if desired, and use it to reinstrument the program like this:
  
            pat_build -O vasp_ncl+pat+44280-4214s.apa

Table 1:  Profile by Function

  Samp% |      Samp |     Imb. |  Imb. | Group
        |           |     Samp | Samp% |  Function
        |           |          |       |   PE=HIDE
       
 100.0% | 420,010.5 |       -- |    -- | Total
|--------------------------------------------------------------------------
|  38.9% | 163,316.9 |       -- |    -- | ETC
||-------------------------------------------------------------------------
||   7.3% |  30,632.2 |  8,302.8 | 21.4% | LAX16_N4_Loop_M16gas_1
||   6.7% |  28,276.1 |  3,936.9 | 12.2% | LAY16_Loop_M16gas_1
||   4.9% |  20,562.0 |  4,609.0 | 18.3% | LAX16_N4_Loop_M16_Oddgas_1
||   4.0% |  16,782.1 |  4,030.9 | 19.4% | LAX16_N4_Loop_M16_Evengas_1
||   2.9% |  12,178.0 |  1,960.0 | 13.9% | mkl_dft_avx_compute_fwd_d_c2c_1d_i
||   2.1% |   8,871.2 |  1,063.8 | 10.7% | mkl_dft_avx_compute_bwd_d_c2c_1d_i
||   1.7% |   7,021.7 |  1,352.3 | 16.2% | mkl_blas_dgemv
||   1.1% |   4,628.5 |    582.5 | 11.2% | __intel_memset
||=========================================================================
|  33.5% | 140,586.8 |       -- |    -- | MPI
||-------------------------------------------------------------------------
||  17.5% |  73,456.9 | 39,081.1 | 34.8% | MPI_ALLREDUCE
||   4.5% |  18,749.1 | 18,756.9 | 50.1% | MPI_REDUCE
||   4.1% |  17,065.0 |  9,145.0 | 34.9% | mpi_alltoallv
||   3.7% |  15,728.6 |  7,103.4 | 31.2% | mpi_bcast
||   2.4% |  10,068.3 | 10,074.7 | 50.1% | mpi_send
||   1.0% |   4,364.4 |  1,986.6 | 31.3% | mpi_barrier
||=========================================================================
|  25.1% | 105,594.8 |       -- |    -- | USER
||-------------------------------------------------------------------------
||   4.1% |  17,314.0 |  3,060.0 | 15.0% | pw_charge_trace_
||   4.0% |  16,695.7 |  3,279.3 | 16.4% | vhamil_trace_
||   2.5% |  10,291.6 |  1,026.4 |  9.1% | racc0mu_hf_
||   2.3% |   9,803.5 |  1,729.5 | 15.0% | map_backward_
||   2.3% |   9,751.9 |  1,711.1 | 14.9% | fock_mp_fock_force_
||   2.1% |   8,961.0 |  1,038.0 | 10.4% | nonlr_mp_rpro1_hf_
||   2.0% |   8,275.6 |  1,966.4 | 19.2% | map_forward_
||   1.7% |   7,250.7 |    944.3 | 11.5% | nonlr_mp_rpromu_hf_
||=========================================================================
|   2.4% |  10,031.6 |       -- |    -- | BLAS
|==========================================================================

Notes for table 2:

  Table option:
    -O profile_max
  Options implied by table option:
    -d ti%@0.95,ti,imb_ti,imb_ti% -b fu,pe=[max,min] -s aggr_fu=max -s
    aggr_pe=max -s aggr_th=max -s total=HIDE

  Options for related tables:
    -O profile_pe_th           -O profile_pe.th       
    -O profile_th_pe           -O profile+src         
    -O load_balance            -O callers             
    -O callers+src             -O calltree            
    -O calltree+src        

  The Function value for Samp is the max of the PE values.
    (To specify different aggregations, see: pat_help report options s1)

  This table shows only lines with Samp% > 0.95.
    (To set thresholds to zero, specify:  -T)
  This table shows only the maximum, minimum PE entries, sorted by
    Samp.

  Imbalance percentages are relative to a set of threads or PEs.
  Other percentages at each level are of the Total for the program.
    (For percentages relative to next level up, specify:
      -s percent=r[elative])

  To make the profile easier to interpret, some samples are attributed
  to a caller that is either a user defined function, or a library
  function called directly by a user defined function.  To disable this
  adjustment, and show functions actually sampled, use the -P option.

Table 2:  Profile of maximum function times (limited entries shown)

  Samp% |      Samp |     Imb. |   Imb. | Function
        |           |     Samp |  Samp% |  PE=[max,min]
|-----------------------------------------------------------------------------
| 100.0% | 112,538.0 | 39,081.1 |  34.8% | MPI_ALLREDUCE
||----------------------------------------------------------------------------
|| 100.0% | 112,538.0 |       -- |     -- | pe.326
||  26.0% |  29,313.0 |       -- |     -- | pe.425
||============================================================================
|  34.6% |  38,935.0 |  8,302.8 |  21.4% | LAX16_N4_Loop_M16gas_1
||----------------------------------------------------------------------------
||  34.6% |  38,935.0 |       -- |     -- | pe.425
||  20.6% |  23,149.0 |       -- |     -- | pe.540
||============================================================================
|  33.3% |  37,506.0 | 18,756.9 |  50.1% | MPI_REDUCE
||----------------------------------------------------------------------------
||  33.3% |  37,506.0 |       -- |     -- | pe.384
||   0.0% |       0.0 |       -- |     -- | pe.338
||============================================================================
|  28.6% |  32,213.0 |  3,936.9 |  12.2% | LAY16_Loop_M16gas_1
||----------------------------------------------------------------------------
||  28.6% |  32,213.0 |       -- |     -- | pe.40
||  23.3% |  26,259.0 |       -- |     -- | pe.146
||============================================================================
|  26.5% |  29,835.0 | 29,796.2 | 100.0% | for_write_seq_fmt
||----------------------------------------------------------------------------
||  26.5% |  29,835.0 |       -- |     -- | pe.0
||   0.0% |       0.0 |       -- |     -- | pe.767
||============================================================================
|  23.3% |  26,210.0 |  9,145.0 |  34.9% | mpi_alltoallv
||----------------------------------------------------------------------------
||  23.3% |  26,210.0 |       -- |     -- | pe.418
||  10.9% |  12,251.0 |       -- |     -- | pe.521
||============================================================================
|  22.4% |  25,171.0 |  4,609.0 |  18.3% | LAX16_N4_Loop_M16_Oddgas_1
||----------------------------------------------------------------------------
||  22.4% |  25,171.0 |       -- |     -- | pe.92
||  14.4% |  16,200.0 |       -- |     -- | pe.206
||============================================================================
|  20.3% |  22,832.0 |  7,103.4 |  31.2% | mpi_bcast
||----------------------------------------------------------------------------
||  20.3% |  22,832.0 |       -- |     -- | pe.337
||   4.4% |   4,969.0 |       -- |     -- | pe.0
||============================================================================
|  18.5% |  20,813.0 |  4,030.9 |  19.4% | LAX16_N4_Loop_M16_Evengas_1
||----------------------------------------------------------------------------
||  18.5% |  20,813.0 |       -- |     -- | pe.92
||  11.3% |  12,741.0 |       -- |     -- | pe.134
||============================================================================
|  18.1% |  20,374.0 |  3,060.0 |  15.0% | pw_charge_trace_
||----------------------------------------------------------------------------
||  18.1% |  20,374.0 |       -- |     -- | pe.53
||  12.9% |  14,483.0 |       -- |     -- | pe.560
||============================================================================
|  17.9% |  20,143.0 | 10,074.7 |  50.1% | mpi_send
||----------------------------------------------------------------------------
||  17.9% |  20,143.0 |       -- |     -- | pe.440
||   0.0% |       0.0 |       -- |     -- | pe.383
||============================================================================
|  17.7% |  19,975.0 |  3,279.3 |  16.4% | vhamil_trace_
||----------------------------------------------------------------------------
||  17.7% |  19,975.0 |       -- |     -- | pe.436
||  12.0% |  13,477.0 |       -- |     -- | pe.636
||============================================================================
|  12.6% |  14,138.0 |  1,960.0 |  13.9% | mkl_dft_avx_compute_fwd_d_c2c_1d_i
||----------------------------------------------------------------------------
||  12.6% |  14,138.0 |       -- |     -- | pe.427
||   9.0% |  10,154.0 |       -- |     -- | pe.224
||============================================================================
|  10.2% |  11,533.0 |  1,729.5 |  15.0% | map_backward_
||----------------------------------------------------------------------------
||  10.2% |  11,533.0 |       -- |     -- | pe.420
||   7.7% |   8,705.0 |       -- |     -- | pe.335
||============================================================================
|  10.2% |  11,463.0 |  1,711.1 |  14.9% | fock_mp_fock_force_
||----------------------------------------------------------------------------
||  10.2% |  11,463.0 |       -- |     -- | pe.424
||   7.8% |   8,745.0 |       -- |     -- | pe.300
||============================================================================
|  10.1% |  11,318.0 |  1,026.4 |   9.1% | racc0mu_hf_
||----------------------------------------------------------------------------
||  10.1% |  11,318.0 |       -- |     -- | pe.385
||   8.4% |   9,416.0 |       -- |     -- | pe.287
||============================================================================
|   9.1% |  10,242.0 |  1,966.4 |  19.2% | map_forward_
||----------------------------------------------------------------------------
||   9.1% |  10,242.0 |       -- |     -- | pe.423
||   6.5% |   7,293.0 |       -- |     -- | pe.526
||============================================================================
|   8.9% |   9,999.0 |  1,038.0 |  10.4% | nonlr_mp_rpro1_hf_
||----------------------------------------------------------------------------
||   8.9% |   9,999.0 |       -- |     -- | pe.426
||   7.3% |   8,162.0 |       -- |     -- | pe.704
||============================================================================
|   8.8% |   9,935.0 |  1,063.8 |  10.7% | mkl_dft_avx_compute_bwd_d_c2c_1d_i
||----------------------------------------------------------------------------
||   8.8% |   9,935.0 |       -- |     -- | pe.426
||   7.3% |   8,191.0 |       -- |     -- | pe.347
||============================================================================
|   7.4% |   8,374.0 |  1,352.3 |  16.2% | mkl_blas_dgemv
||----------------------------------------------------------------------------
||   7.4% |   8,374.0 |       -- |     -- | pe.424
||   5.7% |   6,368.0 |       -- |     -- | pe.343
||============================================================================
|   7.3% |   8,195.0 |    944.3 |  11.5% | nonlr_mp_rpromu_hf_
||----------------------------------------------------------------------------
||   7.3% |   8,195.0 |       -- |     -- | pe.417
||   5.8% |   6,573.0 |       -- |     -- | pe.328
||============================================================================
|   5.6% |   6,351.0 |  1,986.6 |  31.3% | mpi_barrier
||----------------------------------------------------------------------------
||   5.6% |   6,351.0 |       -- |     -- | pe.512
||   1.7% |   1,898.0 |       -- |     -- | pe.427
||============================================================================
|   4.6% |   5,211.0 |    582.5 |  11.2% | __intel_memset
||----------------------------------------------------------------------------
||   4.6% |   5,211.0 |       -- |     -- | pe.0
||   3.7% |   4,138.0 |       -- |     -- | pe.730
||============================================================================
|   4.4% |   4,925.0 |    970.4 |  19.7% | augfast_mp_calc_dllmm_trans_
||----------------------------------------------------------------------------
||   4.4% |   4,925.0 |       -- |     -- | pe.72
||   2.9% |   3,252.0 |       -- |     -- | pe.320
||============================================================================
|   3.6% |   4,013.0 |    523.2 |  13.1% | fock_mp_fock_acc_
||----------------------------------------------------------------------------
||   3.6% |   4,013.0 |       -- |     -- | pe.421
||   2.9% |   3,219.0 |       -- |     -- | pe.526
||============================================================================
|   3.1% |   3,518.0 |    430.0 |  12.2% | mkl_blas_avx_dgemm_kernel_1_0
||----------------------------------------------------------------------------
||   3.1% |   3,518.0 |       -- |     -- | pe.427
||   2.4% |   2,698.0 |       -- |     -- | pe.700
||============================================================================
|   3.0% |   3,385.0 |    415.6 |  12.3% | mkl_blas_avx_dgemm_kernel_0
||----------------------------------------------------------------------------
||   3.0% |   3,385.0 |       -- |     -- | pe.427
||   2.3% |   2,620.0 |       -- |     -- | pe.716
||============================================================================
|   2.7% |   3,043.0 |    436.9 |  14.4% | mkl_dft_avx_coDFTColTwid_Compact_Bwd_v_6_d
||----------------------------------------------------------------------------
||   2.7% |   3,043.0 |       -- |     -- | pe.420
||   2.1% |   2,312.0 |       -- |     -- | pe.719
||============================================================================
|   2.5% |   2,813.0 |  1,692.7 |  60.3% | LSteps1_X16_Y16_Loop32gas_1
||----------------------------------------------------------------------------
||   2.5% |   2,813.0 |       -- |     -- | pe.56
||   0.8% |     863.0 |       -- |     -- | pe.280
||============================================================================
|   2.5% |   2,782.0 |    473.3 |  17.0% | mkl_dft_avx_coDFTColBatch_Compact_Bwd_v_8_d
||----------------------------------------------------------------------------
||   2.5% |   2,782.0 |       -- |     -- | pe.423
||   1.8% |   2,058.0 |       -- |     -- | pe.707
||============================================================================
|   2.4% |   2,681.0 |    463.2 |  17.3% | LN1_Loop_M8gas_1
||----------------------------------------------------------------------------
||   2.4% |   2,681.0 |       -- |     -- | pe.40
||   1.7% |   1,951.0 |       -- |     -- | pe.700
||============================================================================
|   2.3% |   2,634.0 |  2,630.6 | 100.0% | for_write_seq_fmt_xmit
||----------------------------------------------------------------------------
||   2.3% |   2,634.0 |       -- |     -- | pe.0
||   0.0% |       0.0 |       -- |     -- | pe.767
||============================================================================
|   2.3% |   2,628.0 |    354.3 |  13.5% | mkl_dft_avx_coDFTColTwid_Compact_Fwd_v_6_d
||----------------------------------------------------------------------------
||   2.3% |   2,628.0 |       -- |     -- | pe.420
||   1.8% |   2,034.0 |       -- |     -- | pe.552
||============================================================================
|   2.0% |   2,297.0 |    326.3 |  14.2% | mkl_blas_avx_xdgemm
||----------------------------------------------------------------------------
||   2.0% |   2,297.0 |       -- |     -- | pe.41
||   1.5% |   1,683.0 |       -- |     -- | pe.358
||============================================================================
|   1.9% |   2,164.0 |    560.2 |  25.9% | LAX16_N1_Loop_M16_Oddgas_1
||----------------------------------------------------------------------------
||   1.9% |   2,164.0 |       -- |     -- | pe.384
||   1.0% |   1,162.0 |       -- |     -- | pe.134
||============================================================================
|   1.9% |   2,089.0 |    242.2 |  11.6% | mkl_dft_avx_coDFTColBatch_Compact_Fwd_v_8_d
||----------------------------------------------------------------------------
||   1.9% |   2,089.0 |       -- |     -- | pe.409
||   1.5% |   1,668.0 |       -- |     -- | pe.708
||============================================================================
|   1.8% |   2,070.0 |    433.9 |  21.0% | LAX16_N1_Loop_M16gas_1
||----------------------------------------------------------------------------
||   1.8% |   2,070.0 |       -- |     -- | pe.475
||   1.1% |   1,198.0 |       -- |     -- | pe.324
||============================================================================
|   1.6% |   1,850.0 |  1,847.6 | 100.0% | for_write_dir
||----------------------------------------------------------------------------
||   1.6% |   1,850.0 |       -- |     -- | pe.0
||   0.0% |       0.0 |       -- |     -- | pe.767
||============================================================================
|   1.5% |   1,744.0 |     73.4 |   4.2% | rane_
||----------------------------------------------------------------------------
||   1.5% |   1,744.0 |       -- |     -- | pe.287
||   1.4% |   1,591.0 |       -- |     -- | pe.122
||============================================================================
|   1.4% |   1,560.0 |  1,558.0 | 100.0% | cvtas_t_to_a
||----------------------------------------------------------------------------
||   1.4% |   1,560.0 |       -- |     -- | pe.0
||   0.0% |       0.0 |       -- |     -- | pe.767
||============================================================================
|   1.3% |   1,453.0 |    444.4 |  30.6% | mpi_alltoall
||----------------------------------------------------------------------------
||   1.3% |   1,453.0 |       -- |     -- | pe.383
||   0.7% |     762.0 |       -- |     -- | pe.424
||============================================================================
|   1.3% |   1,419.0 |    167.9 |  11.9% | mkl_blas_avx_zgemm_kernel_0
||----------------------------------------------------------------------------
||   1.3% |   1,419.0 |       -- |     -- | pe.0
||   0.4% |     473.0 |       -- |     -- | pe.761
||============================================================================
|   1.2% |   1,344.0 |    198.5 |  14.8% | racc0_hf_
||----------------------------------------------------------------------------
||   1.2% |   1,344.0 |       -- |     -- | pe.45
||   0.9% |     982.0 |       -- |     -- | pe.728
||============================================================================
|   1.2% |   1,335.0 |    186.0 |  14.0% | LAX16_N4_WrapUpgas_1
||----------------------------------------------------------------------------
||   1.2% |   1,335.0 |       -- |     -- | pe.420
||   0.9% |     999.0 |       -- |     -- | pe.644
||============================================================================
|   1.1% |   1,250.0 |  1,242.6 |  99.5% | for_read_seq_fmt
||----------------------------------------------------------------------------
||   1.1% |   1,250.0 |       -- |     -- | pe.0
||   0.0% |       0.0 |       -- |     -- | pe.759
||============================================================================
|   1.1% |   1,204.0 |    436.7 |  36.3% | LAX16_N4_M8_tail_Oddgas_1
||----------------------------------------------------------------------------
||   1.1% |   1,204.0 |       -- |     -- | pe.65
||   0.3% |     372.0 |       -- |     -- | pe.687
||============================================================================
|   1.0% |   1,150.0 |    156.7 |  13.6% | mkl_blas_avx_dgemm_copybn
||----------------------------------------------------------------------------
||   1.0% |   1,150.0 |       -- |     -- | pe.423
||   0.7% |     834.0 |       -- |     -- | pe.176
||============================================================================
|   1.0% |   1,105.0 |    180.5 |  16.4% | augfast_mp_depsum_two_bands_rholm_trace_
||----------------------------------------------------------------------------
||   1.0% |   1,105.0 |       -- |     -- | pe.8
||   0.7% |     795.0 |       -- |     -- | pe.346
|=============================================================================

===================  Observations and suggestions  ===================

MPI Grid Detection:

    There appears to be point-to-point MPI communication in a 192 X 2 X
    2 grid pattern. The 33.5% of the total execution time spent in MPI
    functions might be reduced with a rank order that maximizes
    communication between ranks on the same node. The effect of several
    rank orders is estimated below.

    A file named MPICH_RANK_ORDER.Grid was generated along with this
    report and contains usage instructions and the Custom rank order
    from the following table.

    Rank Order    On-Node    On-Node  MPICH_RANK_REORDER_METHOD
                 Bytes/PE  Bytes/PE%  
                            of Total  
                            Bytes/PE  

        Custom  1.081e+10     39.47%  3
           SMP  7.612e+09     27.78%  1
    RoundRobin  6.400e+09     23.36%  0
          Fold  5.824e+09     21.26%  2


Metric-Based Rank Order:

    When the use of a shared resource like memory bandwidth is unbalanced
    across nodes, total execution time may be reduced with a rank order
    that improves the balance.  The metric used here for resource usage
    is: USER Samp

    For each node, the metric values for the ranks on that node are
    summed.  The maximum and average value of those sums are shown below
    for both the current rank order and a custom rank order that seeks
    to reduce the maximum value.

    A file named MPICH_RANK_ORDER.USER_Samp was generated
    along with this report and contains usage instructions and the
    Custom rank order from the following table.

       Rank    Node Reduction    Maximum  Average
      Order  Metric    in Max      Value  Value
               Imb.     Value             

    Current   6.66%            2.715e+06  2.534e+06
     Custom   0.07%    6.593%  2.536e+06  2.534e+06


MPI Hybrid Rank Order:

    A hybrid rank order has been calculated that attempts to take both
    the MPI communication and USER Samp resources into account.
    The table below shows the metric-based calculations along with the
    final on-node bytes/PE value.  A MPICH_RANK_ORDER.USER_Samp_hybrid
    file was generated along with this report and contains usage
    instructions for this custom rank order.

       Rank    Node Reduction    Maximum    Average  On-Node
      Order  Metric    in Max      Value      Value  Bytes/PE%
               Imb.     Value                        of Total
                                                     Bytes/PE

    Current   6.66%            2.715e+06  2.534e+06  27.78%
     Custom   1.84%     4.91%  2.582e+06  2.534e+06  24.98%


MPI utilization:

    The time spent processing MPI communications is relatively high and
    not evenly balanced over all PEs.  Functions and callsites
    responsible for consuming the most time can be found in the table
    generated by pat_report -O callers+src (within the MPI group).

=========================  End Observations  =========================

Notes for table 3:

  Table option:
    -O samp_profile+src
  Options implied by table option:
    -d sa%@0.95,sa,imb_sa,imb_sa% -b gr,fu,so,li,pe=HIDE

  Options for related tables:
    -O samp_profile            -O profile_max         

  The Total value for Samp is the sum of the Group values.
  The Group value for Samp is the sum of the Function values.
  The Function value for Samp is the sum of the Source values.
  The Source value for Samp is the sum of the Line values.
  The Line value for Samp is the avg of the PE values.
    (To specify different aggregations, see: pat_help report options s1)

  This table shows only lines with Samp% > 0.95.
    (To set thresholds to zero, specify:  -T)

  Imbalance percentages are relative to a set of threads or PEs.
  Other percentages at each level are of the Total for the program.
    (For percentages relative to next level up, specify:
      -s percent=r[elative])

  To make the profile easier to interpret, some samples are attributed
  to a caller that is either a user defined function, or a library
  function called directly by a user defined function.  To disable this
  adjustment, and show functions actually sampled, use the -P option.
  
  The following groups were pruned due to thresholding:
    SYSCALL, IO, HEAP, PTHREAD, RT, MATH, STDIO, BLACS, SCALAPACK, FFTW,
    PBLAS, STRING

Table 3:  Profile by Group, Function, and Line

  Samp% |      Samp |     Imb. |  Imb. | Group
        |           |     Samp | Samp% |  Function
        |           |          |       |   Source
        |           |          |       |    Line
        |           |          |       |     PE=HIDE
       
 100.0% | 420,010.5 |       -- |    -- | Total
|--------------------------------------------------------------------------
|  38.9% | 163,316.9 |       -- |    -- | ETC
||-------------------------------------------------------------------------
||   7.3% |  30,632.2 |  8,302.8 | 21.4% | LAX16_N4_Loop_M16gas_1
||   6.7% |  28,276.1 |  3,936.9 | 12.2% | LAY16_Loop_M16gas_1
||   4.9% |  20,562.0 |  4,609.0 | 18.3% | LAX16_N4_Loop_M16_Oddgas_1
||   4.0% |  16,782.1 |  4,030.9 | 19.4% | LAX16_N4_Loop_M16_Evengas_1
||   2.9% |  12,178.0 |  1,960.0 | 13.9% | mkl_dft_avx_compute_fwd_d_c2c_1d_i
||   2.1% |   8,871.2 |  1,063.8 | 10.7% | mkl_dft_avx_compute_bwd_d_c2c_1d_i
||   1.7% |   7,021.7 |  1,352.3 | 16.2% | mkl_blas_dgemv
||   1.1% |   4,628.5 |    582.5 | 11.2% | __intel_memset
||=========================================================================
|  33.5% | 140,586.8 |       -- |    -- | MPI
||-------------------------------------------------------------------------
||  17.5% |  73,456.9 | 39,081.1 | 34.8% | MPI_ALLREDUCE
||   4.5% |  18,749.1 | 18,756.9 | 50.1% | MPI_REDUCE
||   4.1% |  17,065.0 |  9,145.0 | 34.9% | mpi_alltoallv
||   3.7% |  15,728.6 |  7,103.4 | 31.2% | mpi_bcast
||   2.4% |  10,068.3 | 10,074.7 | 50.1% | mpi_send
||   1.0% |   4,364.4 |  1,986.6 | 31.3% | mpi_barrier
||=========================================================================
|  25.1% | 105,594.8 |       -- |    -- | USER
||-------------------------------------------------------------------------
||   4.1% |  17,314.0 |       -- |    -- | pw_charge_trace_
3|        |           |          |       |  vasp.5.4.4/build/ncl/hamil.F
||||-----------------------------------------------------------------------
4|||   1.8% |   7,517.2 |  2,098.8 | 21.9% | line.1462
4|||   1.5% |   6,319.0 |  1,180.0 | 15.8% | line.1469
||||=======================================================================
||   4.0% |  16,695.7 |       -- |    -- | vhamil_trace_
3|        |           |          |       |  vasp.5.4.4/build/ncl/hamil.F
||||-----------------------------------------------------------------------
4|||   1.8% |   7,374.4 |  2,536.6 | 25.6% | line.1327
4|||   1.7% |   7,186.0 |  2,444.0 | 25.4% | line.1334
||||=======================================================================
||   2.5% |  10,291.6 |       -- |    -- | racc0mu_hf_
3|        |           |          |       |  vasp.5.4.4/build/ncl/nonlr.F
4|   2.1% |   8,998.1 |    965.9 |  9.7% |   line.4111
||   2.3% |   9,803.5 |       -- |    -- | map_backward_
3|        |           |          |       |  vasp.5.4.4/build/ncl/fftmpi_map.F
||||-----------------------------------------------------------------------
4|||   1.0% |   4,293.7 |    612.3 | 12.5% | line.438
4|||   1.0% |   4,005.2 |  1,162.8 | 22.5% | line.457
||||=======================================================================
||   2.3% |   9,751.9 |       -- |    -- | fock_mp_fock_force_
3|        |           |          |       |  vasp.5.4.4/build/ncl/fock.F
||   2.1% |   8,961.0 |       -- |    -- | nonlr_mp_rpro1_hf_
3|        |           |          |       |  vasp.5.4.4/build/ncl/nonlr.F
4|   1.7% |   7,336.5 |    914.5 | 11.1% |   line.4057
||   2.0% |   8,275.6 |       -- |    -- | map_forward_
3|        |           |          |       |  vasp.5.4.4/build/ncl/fftmpi_map.F
4|   1.2% |   4,914.4 |  1,388.6 | 22.1% |   line.457
||   1.7% |   7,250.7 |       -- |    -- | nonlr_mp_rpromu_hf_
3|        |           |          |       |  vasp.5.4.4/build/ncl/nonlr.F
4|   1.5% |   6,149.9 |    877.1 | 12.5% |   line.4057
||=========================================================================
|   2.4% |  10,031.6 |       -- |    -- | BLAS
|==========================================================================

Notes for table 4:

  Table option:
    -O hwpc
  Options implied by table option:
    -d P -b pe=HIDE -s show_data=rows

  The Total value for each data item is the avg of the PE values.
    (To specify different aggregations, see: pat_help report options s1)

  
  Percent of peak FP Ops based on a compute unit.

Table 4:  Program HW Performance Counter Data

PE=HIDE

  
==============================================================================
  Avg of PE values
------------------------------------------------------------------------------
  CPU_CLK_UNHALTED:THREAD_P                       12,243,135,636,960 
  CPU_CLK_UNHALTED:REF_P                             417,113,839,473 
  DTLB_LOAD_MISSES:MISS_CAUSES_A_WALK                  5,635,610,371 
  DTLB_STORE_MISSES:MISS_CAUSES_A_WALK                 1,116,111,104 
  L1D:REPLACEMENT                                    527,687,407,968 
  L2_RQSTS:ALL_DEMAND_DATA_RD                        417,153,668,480 
  L2_RQSTS:DEMAND_DATA_RD_HIT                        320,745,528,788 
  FP_COMP_OPS_EXE:SSE_SCALAR_DOUBLE                  112,744,249,904 
  FP_COMP_OPS_EXE:SSE_FP_SCALAR_SINGLE                     2,551,544 
  FP_COMP_OPS_EXE:X87                                127,011,849,454 
  FP_COMP_OPS_EXE:SSE_PACKED_SINGLE                            1,068 
  FP_COMP_OPS_EXE:SSE_FP_PACKED_DOUBLE             3,233,709,536,337 
  SIMD_FP_256:PACKED_SINGLE                                3,573,961 
  SIMD_FP_256:PACKED_DOUBLE                          724,563,383,669 
  PM_ENERGY:NODE                   13.362 /sec                56,230 J
  CPU_CLK                            2.94GHz                         
  HW FP Ops / User time         2,282.623M/sec     9,605,459,854,214 ops  9.8%peak(DP)
  Total SP ops                      0.007M/sec            31,147,508 ops
  Total DP ops                  2,282.616M/sec     9,605,428,706,706 ops
  MFLOPS (aggregate)         1,753,054.57M/sec                       
  D2 cache hit,miss ratio           81.7% hits                 18.3% misses
  D2 to D1 bandwidth            6,050.513MiB/sec  26,697,834,782,718 bytes
==============================================================================

Notes for table 5:

  Table option:
    -O program_energy
  Options implied by table option:
    -d PM_ENERGY:NODE,Pn,PM_ENERGY:ACC,Pa -b ni=[mmm],pe.th=HIDE -s
    aggr_ni_PM_ENERGY:ACC=sum -s aggr_ni_PM_ENERGY:NODE=sum -s
    aggr_pe.th_PM_ENERGY:ACC=max -s aggr_pe.th_PM_ENERGY:NODE=max

  The Total value for PM_ENERGY:NODE is the sum of the Node Id values.
  The Node Id value for PM_ENERGY:NODE is the max of the PE.Thread values.
    (To specify different aggregations, see: pat_help report options s1)

  This table shows only the maximum, median, minimum Node Id entries,
    sorted by PM_ENERGY:NODE.

Table 5:
  Program energy and power usage (from Cray PM) (limited entries shown)

  PM_ENERGY | Power:node | Node Id=[mmm]
  :NODE (J) |        (W) |  PE.Thread=HIDE
           
 43,184,906 | 10,204.843 | Total
|-----------------------------------------
|  1,402,143 |    331.061 | nid.4214
|  1,348,587 |    318.576 | nid.4261
|  1,312,174 |    310.262 | nid.4310
|=========================================

Notes for table 6:

  Table option:
    -O himem
  Options implied by table option:
    -d hm,Hm -b nn,pe=HIDE -s sort_by_nn=yes

  The Total value for each data item is the sum of the Numanode values.
  The Numanode value for each data item is the avg of the PE values.
    (To specify different aggregations, see: pat_help report options s1)

  The value shown for Process HiMem is calculated from information in
  the /proc/self/numa_maps files captured near the end of the program. 
  It is the total size of all pages, including huge pages, that were
  actually mapped into physical memory from both private and shared
  memory segments.


Table 6:  Memory High Water Mark by Numa Node

  Process |    HiMem |    HiMem | Numanode
    HiMem |     Numa |     Numa |  PE=HIDE
 (MBytes) |   Node 0 |   Node 1 | 
          | (MBytes) | (MBytes) | 
         
  1,151.1 |    583.6 |    567.5 | Total
|-------------------------------------------
|    575.9 |    573.5 |      2.4 | numanode.0
|    575.2 |     10.1 |    565.1 | numanode.1
|===========================================

Notes for table 7:

  Table option:
    -O program_time
  Options implied by table option:
    -d pt,hm -b pe=[mmm]

  The Total value for Process HiMem (MBytes), Process Time is the avg of the PE values.
    (To specify different aggregations, see: pat_help report options s1)

  The value shown for Process HiMem is calculated from information in
  the /proc/self/numa_maps files captured near the end of the program. 
  It is the total size of all pages, including huge pages, that were
  actually mapped into physical memory from both private and shared
  memory segments.

  This table shows only the maximum, median, minimum PE entries,
    sorted by Process Time.

Table 7:  Wall Clock Time, Memory High Water Mark (limited entries shown)

 Process Time |  Process | PE=[mmm]
              |    HiMem | 
              | (MBytes) | 
             
 4,231.805194 |    575.6 | Avg of PE values
|------------------------------------------
| 4,349.106319 |    585.5 | pe.0
| 4,226.690202 |    574.2 | pe.638
| 4,217.939547 |    574.2 | pe.652
|==========================================

========================  Additional details  ========================

Experiment:  samp_cs_time

Sampling interval:  10000 microsecs

Original path to data file:
  /fs3/z01/z01/aturner/benchmark/VASP/CdTe_Hybrid/vasp_ncl+pat+44280-4214s/000000.xf  (RTS)

Original program:
  /home1/z01/z01/aturner/software/VASP/vasp.5.4.4/bin/vasp_ncl

Instrumented with:  pat_build vasp_ncl

  Option file "apa" contained:
    -Drtenv=PAT_RT_PERFCTR=default_samp
    -Drtenv=PAT_RT_EXPERIMENT=samp_cs_time
    -Drtenv=PAT_RT_SAMPLING_MODE=3
    -g upc
    -g caf
    -g mpi
    -g shmem
    -g syscall

Instrumented program:
  /home/z01/z01/aturner/software/VASP/vasp.5.4.4/bin/vasp_ncl+pat

Program invocation:
  /home/z01/z01/aturner/software/VASP/vasp.5.4.4/bin/vasp_ncl+pat

Exit Status:  0 for 768 PEs

Memory pagesize:  4 KiB

Memory hugepagesize:  Not Available

Programming environment:  CRAY

Runtime environment variables:
  ATP_HOME=/opt/cray/atp/2.1.0
  ATP_IGNORE_SIGTERM=1
  ATP_MRNET_COMM_PATH=/opt/cray/atp/2.1.0/libexec/atp_mrnet_commnode_wrapper
  ATP_POST_LINK_OPTS=-Wl,-L/opt/cray/atp/2.1.0/libApp/ 
  CRAYOS_VERSION=5.2.82
  CRAYPE_VERSION=2.5.10
  CRAY_BINUTILS_VERSION=/opt/cray/cce/8.5.8
  CRAY_CC_VERSION=8.5.8
  CRAY_FTN_VERSION=8.5.8
  CRAY_LIBSCI_VERSION=16.11.1
  LIBSCI_VERSION=16.11.1
  MODULE_VERSION=3.2.10.6
  MODULE_VERSION_STACK=3.2.10.6
  MPICH_ABORT_ON_ERROR=1
  MPICH_DIR=/opt/cray/mpt/7.5.5/gni/mpich-cray/8.4
  OMP_NUM_THREADS=1
  PATH=/opt/cray/perftools/6.4.6/bin:/opt/cray/papi/5.5.1.1/bin:/home/z01/z01/aturner/temp/texlive/2018/bin/x86_64-linux:/home/z01/z01/aturner/temp/texlive/2018/bin/x86_64-linux:/opt/cray/mpt/7.5.5/gni/bin:/opt/pbs/13.0.412.192482/bin:/opt/cray/rca/1.0.0-2.0502.60530.1.62.ari/bin:/opt/cray/craype/2.5.10/bin:/opt/cray/cce/8.5.8/cray-binutils/x86_64-pc-linux-gnu/bin:/opt/cray/cce/8.5.8/craylibs/x86-64/bin:/opt/cray/cce/8.5.8/cftn/bin:/opt/cray/cce/8.5.8/CC/bin:/opt/cray/llm/default/bin:/opt/cray/llm/default/etc:/opt/cray/xpmem/0.1-2.0502.64982.7.26.ari/bin:/opt/cray/ugni/6.0-1.0502.10863.8.29.ari/bin:/opt/cray/udreg/2.3.2-1.0502.10518.2.17.ari/bin:/opt/cray/lustre-cray_ari_s/2.5_3.0.101_0.46.1_1.0502.8871.43.1-1.0502.21728.74.6/sbin:/opt/cray/lustre-cray_ari_s/2.5_3.0.101_0.46.1_1.0502.8871.43.1-1.0502.21728.74.6/bin:/opt/cray/alps/5.2.5-2.0502.9955.44.1.ari/sbin:/opt/cray/alps/5.2.5-2.0502.9955.44.1.ari/bin:/opt/cray/sdb/1.1-1.0502.63652.4.25.ari/bin:/opt/cray/nodestat/2.2-1.0502.60539.1.31.ari/bin:/opt/modules/3.2.10.6/bin:/home/z01/z01/aturner/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib/mit/bin:/usr/lib/mit/sbin:.:/usr/lib/qt3/bin:/opt/cray/bin
  PAT_BUILD_PAPI_BASEDIR=/opt/cray/papi/5.5.1.1
  PAT_REPORT_PRUNE_NAME=_cray$mt_start_,__cray_hwpc_,f_cray_hwpc_,cstart,__pat_,pat_region_,PAT_,OMP.slave_loop,slave_entry,_new_slave_entry,THREAD_POOL_join,__libc_start_main,_start,__start,start_thread,__wrap_,UPC_ADIO_,_upc_,upc_,__caf_,__pgas_,syscall
  PAT_RT_EXPERIMENT=samp_cs_time
  PAT_RT_PERFCTR=default_samp
  PAT_RT_SAMPLING_MODE=3
  PERFTOOLS_VERSION=6.4.6
  PMI_FORK_RANK=0
  PMI_GNI_COOKIE=3588096000:3588161536
  PMI_GNI_DEV_ID=0
  PMI_GNI_LOC_ADDR=5494:5494
  PMI_GNI_PTAG=58:59
  XTOS_VERSION=5.2.82

Report time environment variables:
    CRAYPAT_ROOT=/opt/cray/perftools/6.4.6
    PAT_REPORT_PRUNE_NAME=_cray$mt_start_,__cray_hwpc_,f_cray_hwpc_,cstart,__pat_,pat_region_,PAT_,OMP.slave_loop,slave_entry,_new_slave_entry,THREAD_POOL_join,__libc_start_main,_start,__start,start_thread,__wrap_,UPC_ADIO_,_upc_,upc_,__caf_,__pgas_,syscall

Number of MPI control variables collected:  104

  (To see the list, specify: -s mpi_cvar=show)

Report command line options:  <none>

Operating system:
  Linux 3.0.101-0.46.1_1.0502.8871-cray_ari_c #1 SMP Mon Oct 8 17:27:42 UTC 2018

Hardware performance counter events:
   CPU_CLK_UNHALTED:THREAD_P             Cycles when processor is not in halted state:Cycles when thread is not halted
   CPU_CLK_UNHALTED:REF_P                Cycles when processor is not in halted state:Cycles when the core is unhalted (count at 100 Mhz)
   DTLB_LOAD_MISSES:MISS_CAUSES_A_WALK   Data TLB load misses:Demand load miss in all TLB levels which causes a page walk of anypage size
   DTLB_STORE_MISSES:MISS_CAUSES_A_WALK  Data TLB store misses:Miss in all TLB levels that causes a page walk of any page size (4K/2M/4M/1G)
   L1D:REPLACEMENT                       L1D cache:Number of cache lines brought into the L1D cache
   L2_RQSTS:ALL_DEMAND_DATA_RD           L2 requests:Demand  data read requests to L2 cache
   L2_RQSTS:DEMAND_DATA_RD_HIT           L2 requests:Demand data read requests that hit L2
   FP_COMP_OPS_EXE:SSE_SCALAR_DOUBLE     Counts number of floating point events:Number of SSE or AVX-128 double precision FP scalar uops executed
   FP_COMP_OPS_EXE:SSE_FP_SCALAR_SINGLE  Counts number of floating point events:Number of SSE or AVX-128 single precision FP scalar uops executed
   FP_COMP_OPS_EXE:X87                   Counts number of floating point events:Number of X87 uops executed
   FP_COMP_OPS_EXE:SSE_PACKED_SINGLE     Counts number of floating point events:Number of SSE or AVX-128 single precision FP packed uops executed
   FP_COMP_OPS_EXE:SSE_FP_PACKED_DOUBLE  Counts number of floating point events:Number of SSE or AVX-128 double precision FP packed uops executed
   SIMD_FP_256:PACKED_SINGLE             Counts 256-bit packed floating point instructions:Counts 256-bit packed single-precision
   SIMD_FP_256:PACKED_DOUBLE             Counts 256-bit packed floating point instructions:Counts 256-bit packed double-precision
   PM_ENERGY:NODE                        Compute node accumulated energy

  This set of HWPC events requires multiplexing, which reduces
  the accuracy of the data collected. If the best possible
  accuracy is needed, you should rerun to collect data for
  smaller sets of events, that do not require multiplexing.

Number of traced functions:  243

  (To see the list, specify:  -s traced_functions=show)

