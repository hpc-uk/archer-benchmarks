import re
import os

def create_df_list(filelist, cpn):
    """Create a list of dictionaries from multiple GROMACS log files which can
    then be used to create a Pandas dataframe.

    Input parameters are:
    - filelist: list of GROMACS output files (String)
    - cpn: Cores per node for the platform used (Int)

    Returns
    - df_list: A list of dicts than can be used to create a Pandas dataframe
    """
    df_list = []
    for file in filelist:
        if 'smt' in file:
            # Need to recompute cpn based on SMT
            i = file.find('smt')
            smt = int(file[i-1])
        else:
            smt = 1
        resdict = get_perf_dict(file, cpn*smt)
        if resdict is not None:
            df_list.append(resdict) 
    return df_list 

def get_perf_dict(filename, cpn):
    """Extract the details from GROMACS output.

    Input parameters are:
    - filename: The file path to read from (String)
    - cpn: Cores per node of the system the calculation was run on (Int)

    The function returns a dict containing the details extracted from the 
    GROMACS output. This dict has the following fields:

    - Processes: total number of process used as reported by GROMACS
    - Threads: threads per process used as reported by GROMACS
    - Date: the date and time of the run as reported by GROMACS
    - Cores: total cores used (Processes * Threads)
    - Nodes: total nodes used (Cores / Cores per Node)
    - Perf: performance in ns/day
    - Count: set to 1, used for counting entries in performance results
    """
    infile = open(filename, 'r')
    resdict = {}
    tvals = []
    resdict['File'] = os.path.abspath(filename)
    # Use to catch if we are missing data
    resdict['Perf'] = False
    # Processes and Threads default to 1
    resdict['Processes'] = 1
    resdict['Threads'] = 1
    for line in infile:
        if re.search('Performance:', line):
            line = line.strip()
            tokens = line.split()
            resdict['Perf'] = float(tokens[1])
        elif re.search('MPI processes', line):
            line = line.strip()
            tokens = line.split()
            resdict['Processes'] = int(tokens[1])
        elif re.search('per MPI process', line):
            line = line.strip()
            tokens = line.split()
            resdict['Threads'] = int(tokens[1])
        elif re.search('Finished mdrun on', line):
            line = line.strip()
            tokens = line.split()
            resdict['Date'] = " ".join(tokens[5:])         
    infile.close()

    # If we do not have enough SCF cycle data then exit and return None
    if resdict['Perf'] is None:
        resdict = None
        return resdict

    resdict['Cores'] = resdict['Processes'] * resdict['Threads']
    resdict['Nodes'] = max(1, int(resdict['Cores'] / cpn))
    resdict['Count'] = 1

    return resdict

def get_perf_stats(df, stat, threads=None, writestats=False, plot_cores=False):
    if threads is not None:
       query = '(Threads == {0})'.format(threads)
       df = df.query(query)
    df_num = df.drop(['File', 'Date'], 1)
    groupf = {'Perf':['min','median','max','mean'], 'Count':'sum'}
    df_group = df_num.sort_values(by='Nodes').groupby(['Nodes','Cores','Threads']).agg(groupf)
    if writestats:
        print(df_group)
    if plot_cores:
        df_group = df_num.sort_values(by='Cores').groupby(['Cores']).agg(groupf)
    else:
        df_group = df_num.sort_values(by='Nodes').groupby(['Nodes','Cores']).agg(groupf)
    if writestats:
        print(df_group)
    perf = df_group['Perf',stat].tolist()
    count = df_group.index.get_level_values(0).tolist()
    return count, perf

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
    nodeslist = []
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
