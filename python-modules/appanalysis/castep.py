
import re

def getmeancycle(castepfilename):
    """Extract the mean SCF cycle time from CASTEP output. Max and min values are removed."""
    infile = open(castepfilename, 'r')
    tvals = []
    for line in infile:
        if re.search('<-- SCF', line):
            line = line.strip()
            tokens = line.split()
            if re.match('[0-9]+', tokens[0].lstrip()):
                tvals.append(float(tokens[4]))
    infile.close()

    deltat = []
    for i in range(len(tvals)-1):
        deltat.append(tvals[i+1] - tvals[i])
        
    deltat.remove(max(deltat))
    deltat.remove(min(deltat))
    
    return sum(deltat)/len(deltat)

def calcperf(filedict, cpn):
    """Given a list of CASTEP output files, compute the performance and return the data."""
    nodeslist = []
    scflist = []
    perflist = []
    print("{:>15s} {:>15s} {:>15s} {:>26s}".format('Nodes', 'Cores', 'Mean SCF (s)', 'Performance (SCF cycles/s)'))
    print("{:>15s} {:>15s} {:>15s} {:>26s}".format('=====', '=====', '============', '=========================='))
    for nodes, filename in sorted(filedict.items()):
        nodeslist.append(nodes)
        scf = getmeancycle(filename)
        scflist.append(scf)
        perf = 1/float(scf)
        perflist.append(perf)
        print("{:>15d} {:>15d} {:>15.1f} {:>26.6f}".format(nodes, nodes*cpn, scf, perf))
    return nodeslist, scflist, perflist

