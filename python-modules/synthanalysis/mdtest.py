import re

def getperf(filename):
    infile = open(filename, 'r')
    create = -1.0
    stat = -1.0
    remove = -1.0
    for line in infile:
        if re.search('File creation', line):
            line = line.strip()
            tokens = line.split()
            create = float(tokens[5])
        elif re.search('File stat', line):
            line = line.strip()
            tokens = line.split()
            stat = float(tokens[5])
        elif re.search('File removal', line):
            line = line.strip()
            tokens = line.split()
            remove = float(tokens[5])   
    infile.close()
    
    return create, stat, remove

def calcperf(filedict, test, cpn):
    nodeslist = []
    createlist = []
    statlist = []
    removelist = []
    print("{:>15s} {:>15s} {:>15s} {:>15s} {:>15s}".format('Clients', 'Cores', 'Create (ops/s)', 'Stat (ops/s)', 'Remove (ops/s)'))
    print("{:>15s} {:>15s} {:>15s} {:>15s} {:>15s}".format('=======', '=====', '==============', '============', '=============='))
    for nodes, filename in sorted(filedict.items()):
        nodeslist.append(nodes)
        fullname = filename.format(test)
        create, stat, remove = getperf(fullname)
        createlist.append(create)
        statlist.append(stat)
        removelist.append(remove)
        print("{:>15d} {:>15d} {:>15.3f} {:>15.3f} {:>15.3f}".format(nodes, nodes*cpn, create, stat, remove))
    return nodeslist, createlist, statlist, removelist
