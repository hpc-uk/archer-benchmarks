#!/usr/bin/env python
#
# This script computes the length of SCF cycles from CASTEP output
#
import sys
import re

infile = open(sys.argv[1], 'r')

tvals = []
for line in infile:
   if re.search('<-- SCF', line):
      line = line.strip()
      tokens = line.split()
      if re.match('[0-9]+', tokens[0].lstrip()):
         tvals.append(float(tokens[4]))

deltat = []
for i in range(len(tvals)-1):
   deltat.append(tvals[i+1] - tvals[i])

print "Raw data:"
print "   Max SCF time = {:10.2f}".format(max(deltat))
print "   Min SCF time = {:10.2f}".format(min(deltat))
print "  Mean SCF time = {:10.2f}".format(sum(deltat)/len(deltat))

deltat.remove(max(deltat))
deltat.remove(min(deltat))

print "Extreme values removed:"
print "   Max SCF time = {:10.2f}".format(max(deltat))
print "   Min SCF time = {:10.2f}".format(min(deltat))
print "  Mean SCF time = {:10.2f}".format(sum(deltat)/len(deltat))
