
import re
import os

def create_df_list(filelist, cpn, perftype="mean", printfilename=False):
    """Create a list of dictionaries from multiple log files which can
    then be used to create a Pandas dataframe.

    Input parameters are:
    - filelist: list of output files ([String])
    - cpn: Cores per node for the platform used (Int)

    Returns
    - df_list: A list of dicts than can be used to create a Pandas dataframe
    """
    df_list = []
    for file in filelist:
        if printfilename:
            print(file)
        resdict = get_perf_dict(file, cpn, perftype=perftype)
        if resdict is not None:
            df_list.append(resdict) 
    return df_list 

def get_perf_dict(filename, cpn, perftype="mean"):
    """Extract the details from output.

    This routine calculates the time for each LOOP+ cycle in the output, once this
    is done, there are different options on how to transform it.
    
    - mean (default): removes the shortest and longest values and takes the mean of the
      remaining values. This number is considered the runtime for an SCF cycle.
    - max: takes the maximum value from the set of SCF cycle times
    - min: takes the minimum value from the set of SCF cycle times
    
    The performance in 'SCF cycles per second' is also computed.

    Input parameters are:
    - filename: The file path to read from (String)
    - cpn: Cores per node of the system the calculation was run on (Int)

    The function returns a dict containing the details extracted from the 
    output. This dict has the following fields:

    - Processes: total number of process
    - Threads: threads per process used
    - Date: the date and time of the run
    - NPAR: the value of NPAR
    - KPAR: the value of KPAR
    - Cores: total cores used (Processes * Threads)
    - Nodes: total nodes used (Cores / Cores per Node)
    - SCF: SCF cycle time in seconds
    - Perf: performance in SCF cycles per second
    - Count: set to 1, used for counting entries in performance results
    """
    infile = open(filename, 'r')
    resdict = {}
    tvals = []
    resdict['File'] = os.path.abspath(filename)
    # Default to 1 thread
    resdict['Threads'] = 1
    for line in infile:
        if re.search('LOOP\+:', line):
            line = line.strip()
            tokens = line.split()
            if len(tokens) > 6:
                tvals.append(float(tokens[6]))
            else:
                t = tokens[4].replace("time","")
                tvals.append(float(t))
        elif re.search('running on ', line):
            line = line.strip()
            tokens = line.split()
            resdict['Processes'] = int(tokens[2])
        elif re.search('threads', line):
            line = line.strip()
            tokens = line.split()
            resdict['Processes'] = int(tokens[1])
            resdict['Threads'] = int(tokens[4])
        elif re.search('mpi-ranks', line):
            line = line.strip()
            tokens = line.split()
            resdict['Processes'] = int(tokens[1])
        elif re.search('Each process may', line):
            line = line.strip()
            tokens = line.split()
            resdict['Threads'] = int(tokens[6])
        elif re.search('executed on', line):
            line = line.strip()
            tokens = line.split()
            resdict['Date'] = f"{tokens[4].strip()} {tokens[5].strip()}"
        elif re.search('distr:', line):
            line = line.strip()
            tokens = line.split()
            resdict['NCORE'] = int(tokens[5].strip())
            resdict['NPAR'] = int(tokens[7].strip())
        elif re.search('distrk:', line):
            line = line.strip()
            tokens = line.split()
            resdict['KPAR'] = int(tokens[6].strip())            
    infile.close()

    # If we do not have enough SCF cycle data then exit and return None
    if len(tvals) < 1:
        resdict = None
        return resdict

    resdict['Processes'] = resdict.get('Processes', 1)
    resdict['Cores'] = resdict['Processes'] * resdict['Threads']
    # Get number of nodes from filename
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
    resdict['Nodes'] = int(nodestring.replace('nodes',''))

    # Compute the SCF cycle times and remove extreme values
    resdict['LOOP+'] = 0.0
    if perftype == "mean":
        if len(tvals) > 2:
            tvals.remove(max(tvals))
            tvals.remove(min(tvals))
        resdict['LOOP+'] = sum(tvals)/len(tvals)
    if perftype == "max":
        resdict['LOOP+'] = max(tvals)
    if perftype == "min":
        resdict['LOOP+'] = min(tvals)

    resdict['Perf'] = 1.0 / resdict['LOOP+']
    resdict['Count'] = 1

    return resdict

def get_perf_stats(df, stat, threads=None, writestats=False, plot_cores=False):
    if threads is not None:
       query = '(Threads == {0})'.format(threads)
       df = df.query(query)
    df_num = df.drop(['File', 'Date'], 1)
    groupf = {'Perf':['min','median','max','mean'], 'LOOP+':['min','median','max','mean'], 'Count':'sum'}
    if writestats:
        df_group = df_num.sort_values(by='Nodes').groupby(['Nodes','Processes','Threads','Cores','NCORE','NPAR','KPAR']).agg(groupf)
        print(df_group)
    if plot_cores:
        df_group = df_num.sort_values(by='Cores').groupby(['Cores']).agg(groupf)
    else:
        df_group = df_num.sort_values(by='Nodes').groupby(['Nodes']).agg(groupf)
    if writestats:
        print(df_group)
    perf = df_group['Perf',stat].tolist()
    count = df_group.index.get_level_values(0).tolist()
    return count, perf


