import re
import os

def create_df_list(filelist, cpn):
    """Create a list of dictionaries from multiple CP2K log files which can
    then be used to create a Pandas dataframe.

    Input parameters are:
    - filelist: list of CP2K output files ([String])
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
    """Extract the details from CP2K output.

    Input parameters are:
    - filename: The file path to read from (String)
    - cpn: Cores per node of the system the calculation was run on (Int)

    The function returns a dict containing the details extracted from the 
    CP2K output. This dict has the following fields:

    - Processes: total number of process used as reported by CP2K
    - Threads: threads per process used as reported by CP2K
    - Date: the date and time of the run as reported by CP2K
    - Cores: total cores used (Processes * Threads)
    - Nodes: total nodes used (Cores / Cores per Node)
    - Time: Total runtime (in seconds) for the calculation from the CP2K output
    - Perf: performance in calculations per second
    - Count: set to 1, used for counting entries in performance results
    """
    infile = open(filename, 'r')
    resdict = {}
    resdict['File'] = os.path.abspath(filename)
    # Marker to test if we are in the timing section or not
    in_timer = False
    resdict['Time'] = None
    for line in infile:
        if re.search('T I M I N G', line):
            in_timer = True
        elif in_timer and re.search('CP2K', line):
            line = line.strip()
            tokens = line.split()
            resdict['Time'] = float(tokens[6])
            in_timer = False
        elif re.search('Total number of message passing processes', line):
            line = line.strip()
            tokens = line.split()
            resdict['Processes'] = int(tokens[7])
        elif re.search('Number of threads for this process', line):
            line = line.strip()
            tokens = line.split()
            resdict['Threads'] = int(tokens[7])
        elif re.search('PROGRAM STARTED AT', line):
            line = line.strip()
            tokens = line.split()
            resdict['Date'] = " ".join(tokens[7:])        
    infile.close()

    # If we do not have enough SCF cycle data then exit and return None
    if resdict['Time'] is None:
        resdict = None
        return resdict

    resdict['Cores'] = resdict['Processes'] * resdict['Threads']
    resdict['Nodes'] = int(resdict['Cores'] / cpn)
    resdict['Perf'] = 1.0 / resdict['Time']
    resdict['Count'] = 1

    return resdict

def get_perf_stats(df, threads, stat, writestats=False):
    query = '(Threads == {0})'.format(threads)
    df_q = df.query(query)
    df_num = df_q.drop(['File', 'Date'], 1)
    groupf = {'Perf':['min','median','max','mean'], 'Count':'sum'}
    df_group = df_num.sort_values(by='Nodes').groupby(['Nodes','Cores']).agg(groupf)
    if writestats:
        print(df_group)
    perf = df_group['Perf',stat].tolist()
    nodes = df_group.index.get_level_values(0).tolist()
    return nodes, perf