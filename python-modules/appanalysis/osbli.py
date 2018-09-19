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
    resdict['Time'] = False
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

    # Get number of nodes from filename
    tokens = filename.split('_')
    nodestring = tokens[-2]
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

def get_perf_stats(df, stat, writestats=False):
    df_num = df.drop(['File', 'Date'], 1)
    groupf = {'Perf':['min','median','max','mean'], 'Count':'sum'}
    df_group = df_num.sort_values(by='Nodes').groupby(['Nodes','Cores']).agg(groupf)
    if writestats:
        print(df_group)
    perf = df_group['Perf',stat].tolist()
    nodes = df_group.index.get_level_values(0).tolist()
    return nodes, perf


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
