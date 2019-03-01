#!/usr/bin/env bash

set -e

for a in mpi openmp
do
  echo "" > $a.log
  for b in 1 2 4 8 12 16 20 24 28 32 36
  do
    t=`grep Time: ../${a}.${b}.*.log | awk '{print $4}' | fpmean`
    n=`ls ../${a}.${b}.*.log| wc -l`
    echo ${b},${t},${n} >> ${a}.log
  done
done
