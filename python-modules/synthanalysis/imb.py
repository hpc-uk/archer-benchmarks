import re

def get_perf_dict(filename, nodes):
    infile = open(filename, 'r')
    resdict = {}
    indata = False
    for line in infile:
        if indata:
            tokens = line.split()
            if (len(tokens) < 4) or (len(tokens) > 6):
                break
            else:
                size = int(tokens[0])
                key = (nodes, size)
                resdict[key] = float(tokens[-1])
        else:
           if re.search('#bytes', line):
               indata = True
    infile.close()
    
    return resdict

def analyse_perf_matrix(baseline, systems, nodelist, sizelist, perfdict, invert=False):
    basedict = perfdict[baseline]
    ratiodict = {}
    print("{:12s}{:s}".format("","#nodes"))
    header = "{:>12s}".format('#bytes')
    for nodes in nodelist:
        header = "{:s}{:>10d}".format(header, nodes)
    print(header)
    for system in systems:
        print(system)
        sysdict = perfdict[system]
        tdict = {}
        for size in sizelist:
            outstring = "{:>12d}".format(size)
            for nodes in nodelist:
                key = (nodes,size)
                baseperf = basedict.get(key, None)
                perf = sysdict.get(key, None)
                if invert:
                    if baseperf is None:
                        ratio = 0.0
                        tdict[key] = None
                    elif perf is not None:
                        ratio = baseperf/perf
                        tdict[key] = ratio
                    else:
                        ratio = 0.0
                        tdict[key] = None
                else:
                    if (baseperf is None) or (abs(baseperf) < 0.0001):
                        ratio = 0.0
                        tdict[key] = None
                    elif perf is None:
                        ratio = 0.0
                        tdict[key] = None
                    else:
                        ratio = perf/baseperf
                        tdict[key] = ratio
                outstring = outstring + "{:>10.2f}".format(ratio)
            print(outstring)
        ratiodict[system] = tdict

    return ratiodict

def get_node_scaling(nodelist, size, sysdict):
    perflist = []
    for nodes in nodelist:
        key = (nodes,size)
        perflist.append(sysdict.get(key, None))
    return perflist

def get_size_scaling(sizelist, nodes, sysdict):
    perflist = []
    for size in sizelist:
        key = (nodes,size)
        perflist.append(sysdict.get(key, None))
    return perflist


