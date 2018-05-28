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
    sulist = []
    print("{:>15s} {:>15s} {:>15s} {:>15s}".format('Nodes', 'Cores', 'Time (s)', 'Speedup'))
    print("{:>15s} {:>15s} {:>15s} {:>15s}".format('=====', '=====', '========', '======='))
    for nodes, filename in sorted(filedict.items()):
        nodeslist.append(nodes)
        t = gettiming(filename)
        timelist.append(t)
        speedup = timelist[0]/t
        sulist.append(speedup)
        print("{:>15d} {:>15d} {:>15.1f} {:>15.2f}".format(nodes, nodes*cpn, t, speedup))
    return nodeslist, timelist, sulist
