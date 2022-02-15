import re
import os

def create_df_list(filelist, cpn):
    """Create a list of dictionaries from multiple OpenSBLI log files which can
    then be used to create a Pandas dataframe.

    Input parameters are:
    - filelist: list of OpenSBLI output files (String)
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
    """Extract the details from OpenSBLI output.

    Input parameters are:
    - filename: The file path to read from (String)
    - cpn: Cores per node of the system the calculation was run on (Int)

    The function returns a dict containing the details extracted from the 
    OpenSBLI output. This dict has the following fields:

    - Processes: total number of process used as reported by OpenSBLI
    - Date: the date and time of the run as reported by OpenSBLI
    - Cores: total cores used (Processes * Threads)
    - Nodes: total nodes used (Cores / Cores per Node)
    - Time: Time taken for 1 iteration in seconds
    - Perf: performance in iterations per second
    - Count: set to 1, used for counting entries in performance results
    """
    infile = open(filename, 'r')
    resdict = {}
    tvals = []
    resdict['File'] = os.path.abspath(filename)
    # Use to catch if we are missing data
    resdict['Time'] = None
    for line in infile:
        if re.search('Time taken for ', line):
            line = line.strip()
            tokens = line.split(',')
            resdict['Time'] = float(tokens[1])
        elif re.search('Log file opened', line):
            line = line.strip()
            tokens = line.split()
            resdict['Date'] = " ".join(tokens[4:])         
    infile.close()

    # Get number of nodes and possibly threads from filename
    # Default is 1 thread
    resdict['Threads'] = 1
    tokens = filename.split('.')
    filestem = ''
    for token in tokens:
        if 'nodes' in token:
            filestem = token
    tokens = filestem.split('_')
    nodestring = None
    for token in tokens:
        if 'nodes' in token:
            nodestring = token
        elif 'threads' in token:
            resdict['Threads'] = int(token.replace('threads',''))
    resdict['Nodes'] = int(nodestring.replace('nodes',''))

    # If we do not have enough SCF cycle data then exit and return None
    if resdict['Time'] is None:
        resdict = None
        return resdict

    # Get the date/time from the filename
    tokens = filename.split('_')
    resdict['Date'] = tokens[-1]

    resdict['Perf'] = 1.0 / resdict['Time']
    resdict['Processes'] = resdict['Nodes'] * cpn
    resdict['Cores'] = resdict['Processes']
    resdict['Count'] = 1

    return resdict

def get_perf_stats(df, stat, threads=None, writestats=False, plotcores=False):
    if threads is not None:
       query = '(Threads == {0})'.format(threads)
       df = df.query(query)
    groupf = {'Perf':['min','median','max','mean'], 'Time':['min','median','max','mean'], 'Count':'sum'}
    df_group = df.sort_values(by='Nodes').groupby(['Nodes','Cores','Threads']).agg(groupf)
    if writestats:
        print(df_group)
    if plotcores:
        df_group = df.sort_values(by='Cores').groupby(['Cores']).agg(groupf)
    else:
        df_group = df.sort_values(by='Nodes').groupby(['Nodes']).agg(groupf)
    perf = df_group['Perf',stat].tolist()
    count = df_group.index.get_level_values(0).tolist()
    return count, perf

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

def calcperf(filedict, cpn, plot_cores=False):
    plotlist = []
    timelist = []
    perflist = []
    print("{:>15s} {:>15s} {:>15s} {:>20s}".format('Nodes', 'Cores', 'Time (s)', 'Performance (iter/s)'))
    print("{:>15s} {:>15s} {:>15s} {:>20s}".format('=====', '=====', '========', '===================='))
    for nodes, filename in sorted(filedict.items()):
        if plot_cores:
            plotlist.append(nodes*cpn)
        else:
            plotlist.append(nodes)
        t = gettiming(filename)
        timelist.append(t)
        perf = 1.0/t
        perflist.append(perf)
        print("{:>15d} {:>15d} {:>15.1f} {:>20.3f}".format(nodes, nodes*cpn, t, perf))
    return plotlist, timelist, perflist
