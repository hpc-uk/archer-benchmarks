# Results for the HadGEM3-GC31_benchmark on ARCHER

* The timings are averaged over five runs ± standard deviation.
* See ```coupled_run.job``` to understand how the total number of nodes is calculated depending on the UM and the nemo grid sizes.
  * We use two OpenMP threads per process for the UM-model.
  * We use eight XIOS processors.
 * We use the ```UM Run job``` start and end time from ```pe_output/atmos.fort6.pe0``` here, which is slighlty shorter than the overall run time for the batch script (can vary from less than 2% to - rarely - 17%).

UM: | UM_ATM_NPROCX | UM_ATM_NPROCY | NEMO: | NEMO_IPROC (jpni) | NEMO_JPROC (jpnj) | total number of nodes | time (sec)
---- | -------|--------|---------|--------|----------|-------|----
 .  | 48 | 37 | .| 24 |36 | 189 | 1569.80±88.53
 .  | 36 | 37 | .| 24 |36 | 152 | 1801.60±106.90
 .  | 60 | 47 | .| 24 |36 | 276 | 1484.20±71.26
 .  | 60 | 47 | .| 33 |42 | 298 |
 .  | 48 | 37 | .| 33 |42 | 211 | 
 .  | 48 | 37 | .| 12 |18 | 168 | 1793.80±24.55
