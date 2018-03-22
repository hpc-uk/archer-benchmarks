import re

def getperf(filename):
    infile = open(filename, 'r')
    perf = []
    for line in infile:
        if re.search('Performance:', line):
            line = line.strip()
            tokens = line.split()
            perf = float(tokens[1])
    infile.close()
    
    return perf

def calcperf(filedict, cpn):
    nodesslist = []
    perflist = []
    sulist = []
    print("{:>15s} {:>15s} {:>15s} {:>15s}".format('Nodes', 'Cores', 'Perf (ns/day)', 'Speedup'))
    print("{:>15s} {:>15s} {:>15s} {:>15s}".format('=====', '=====', '=============', '======='))
    for nodes, filename in sorted(filedict.items()):
        nodeslist.append(nodes)
        perf = getperf(filename)
        perflist.append(perf)
        speedup = perf/perflist[0]
        sulist.append(speedup)
        print("{:>15d} {:>15d} {:>15.3f} {:>15.2f}".format(nodes, nodes*cpn, perf, speedup))
    return nodeslist, perflist, sulist
