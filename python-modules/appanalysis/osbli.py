import re

def gettiming(filename):
    infile = open(filename, 'r')
    timing = 0.0
    for line in infile:
        if re.search('Time taken for ', line):
            line = line.strip()
            tokens = line.split(',')
            timing = float(tokens[1])
    infile.close()
    return timing

def calcperf(filedict, cpn):
    nodeslist = []
    timelist = []
    perflist = []
    print("{:>15s} {:>15s} {:>15s} {:>20s}".format('Nodes', 'Cores', 'Time (s)', 'Performance (iter/s)'))
    print("{:>15s} {:>15s} {:>15s} {:>20s}".format('=====', '=====', '========', '===================='))
    for nodes, filename in sorted(filedict.items()):
        nodeslist.append(nodes)
        t = gettiming(filename)
        timelist.append(t)
        perf = 1.0/t
        perflist.append(perf)
        print("{:>15d} {:>15d} {:>15.1f} {:>20.3f}".format(nodes, nodes*cpn, t, perf))
    return nodeslist, timelist, perflist
