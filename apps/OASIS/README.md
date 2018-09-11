# OASIS HadGEN-G31 coupled model benchmark

## Build Instructions

The build process followed on each of the systems benchmarked (if available):

* [ARCHER(EPCC)](https://github.com/ebreitmo/build-instructions/blob/master/OASIS/OASIS_ACRHER.md)

## Example job scripts

Example job scripts can be found [here](run/ARCHER/coupled_run.job).
## Results

The output file on ARCHER [link](results/ARCHER).
To check if the run was successfull, see ```coupled_run.oxxx```:
* Usually the model will either crash or run with NaNs if something goes wrong.
* In the UM output check that the following lines don't vary too much:
 ````
 This timestep                         This run
Min theta1     proc          position            Min theta1 timestep
224.76    1712   114.6deg W      83.0deg N       223.38   132
Largest negative delta theta1 at minimum theta1
This timestep =    -0.07K. At min for run =    -3.60K

Maximum vertical velocity at timestep  432       Max w this run
w_max   level  proc         position             run w_max level timestep
0.223E+01  42    747  149.8deg W    -14.9deg S    0.753E+01   40   140

 ````
 * For the following lines the number of iterations shouldn't get too large:
  ````
  ********************************************
*    Linear solve for Helmholtz problem    *
* Outer Inner Iterations InitialError      *
*    2     1       12     0.197758E+00     *
*    2     2        3     0.151540E-02     *
********************************************

  ````
