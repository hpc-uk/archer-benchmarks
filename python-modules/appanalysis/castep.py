
import re
import os

def create_df_list(filelist, cpn):
    """Create a list of dictionaries from multiple CASTEP log files which can
    then be used to create a Pandas dataframe.

    Input parameters are:
    - filelist: list of CASTEP output files ([String])
    - cpn: Cores per node for the platform used (Int)

    Returns
    - df_list: A list of dicts than can be used to create a Pandas dataframe
    """
    df_list = []
    for file in filelist:
        resdict = get_perf_dict(file, cpn)
        if resdict is not None:
            df_list.append(resdict) 
    return df_list 

def get_perf_dict(filename, cpn):
    """Extract the details from CASTEP output.

    This routine calculates the time for each SCF cycle in the output, removes
    the shortest and longest values and takes the mean of the remaining values.
    This number is considered the runtime for an SCF cycle. The performance in
    'SCF cycles per second' is also computed.

    Input parameters are:
    - filename: The file path to read from (String)
    - cpn: Cores per node of the system the calculation was run on (Int)

    The function returns a dict containing the details extracted from the 
    CASTEP output. This dict has the following fields:

    - Processes: total number of process used as reported by CASTEP
    - Threads: threads per process used as reported by CASTEP
    - Date: the date and time of the run as reported by CASTEP
    - Cores: total cores used (Processes * Threads)
    - Nodes: total nodes used (Cores / Cores per Node)
    - SCF: mean SCF cycle time in seconds
    - Perf: performance in SCF cycles per second
    - Count: set to 1, used for counting entries in performance results
    """
    infile = open(filename, 'r')
    resdict = {}
    tvals = []
    resdict['File'] = os.path.abspath(filename)
    # Default to 1 thread as CASTEP only reports threads if > 1
    resdict['Threads'] = 1
    for line in infile:
        if re.search('<-- SCF', line):
            line = line.strip()
            tokens = line.split()
            if re.match('[0-9]+', tokens[0].lstrip()):
                tvals.append(float(tokens[4]))
        elif re.search('Calculation parallelised', line):
            line = line.strip()
            tokens = line.split()
            resdict['Processes'] = int(tokens[3])
        elif re.search('Each process may', line):
            line = line.strip()
            tokens = line.split()
            resdict['Threads'] = int(tokens[6])
        elif re.search('Run started:', line):
            line = line.strip()
            tokens = line.split(',')
            resdict['Date'] = tokens[1].strip()         
    infile.close()

    # If we do not have enough SCF cycle data then exit and return None
    if len(tvals) < 3:
        resdict = None
        return resdict

    resdict['Cores'] = resdict['Processes'] * resdict['Threads']
    resdict['Nodes'] = int(resdict['Cores'] / cpn)

    # Compute the SCF cycle times and remove extreme values
    deltat = []
    for i in range(len(tvals)-1):
        deltat.append(tvals[i+1] - tvals[i])
    deltat.remove(max(deltat))
    deltat.remove(min(deltat))

    resdict['SCF'] = sum(deltat)/len(deltat)
    resdict['Perf'] = 1.0 / resdict['SCF']
    resdict['Count'] = 1

    return resdict

def get_perf_stats(df, stat, threads=None, writestats=False):
    if threads is not None:
       query = '(Threads == {0})'.format(threads)
       df = df.query(query)
    df_num = df.drop(['File', 'Date'], 1)
    groupf = {'Perf':['min','median','max','mean'], 'Count':'sum'}
    df_group = df_num.sort_values(by='Nodes').groupby(['Nodes','Cores']).agg(groupf)
    if writestats:
        print(df_group)
    perf = df_group['Perf',stat].tolist()
    nodes = df_group.index.get_level_values(0).tolist()
    return nodes, perf

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

