import sys
import os.path
import re
from glob import glob

def create_df_list(filelist, cpn):
    """Create a list of dictionaries from multiple benchio log files which can
    then be used to create a Pandas dataframe.

    Input parameters are:
    - filelist: list of benchio output files ([String])
    - cpn: Cores per node for the platform used (Int)

    Returns
    - df_list: A list of dicts than can be used to create a Pandas dataframe
    """
    df_list = []
    for file in filelist:
        resdict = get_perf_dict(file, cpn)
        if resdict is not None:
            df_list.extend(resdict) 
    return df_list 

def get_perf_dict(filename, cpn):
    resframe_proto = []
    infile = open(filename, 'r')
    resdict = {}
    for line in infile:
        if re.search('MPI-IO', line):
            break
        elif re.search('Starting job', line):
            tokens = line.split()
            resdict['JobID'] = tokens[2]
        elif re.search('Running', line):
            tokens = line.split()
            resdict['Writers'] = int(tokens[2])
            resdict['Clients'] = int(float(tokens[2])/cpn)
        elif re.search('Array', line):
            tokens = line.split()
            x = int(tokens[4])
            y = int(tokens[6])
            z = int(tokens[8])
            resdict['LocalSize'] = x
        elif re.search('Global', line):
            tokens = line.split()
            x = int(tokens[4])
            y = int(tokens[6])
            z = int(tokens[8])
            resdict['GlobalSize'] = x
        elif re.search('Total', line):
            tokens = line.split()
            resdict['TotData'] = float(tokens[5])
    infile.close()
    infile = open(filename, 'r')
    timedict = resdict.copy()
    inmpiio = False
    for line in infile:
        if inmpiio:
            if re.search('HDF5', line):
                inmpiio = False
                break
            elif re.search('Writing to', line):
                tokens = line.split()
                nstripe = 0
                if re.match('striped', tokens[2]):
                    timedict['Striping'] = -1
                    nstripe = -1
                elif re.match('defstriped', tokens[2]):
                    timedict['Striping'] = 4
                    nstripe = 4
                elif re.match('unstriped', tokens[2]):
                    timedict['Striping'] = 1
                    nstripe = 1
            elif re.match(' time', line):
                tokens = line.split()
                timedict['Write'] = float(tokens[6])
                timedict['File'] = os.path.abspath(filename)
                timedict['Count'] = 1
                resframe_proto.append(timedict)
                curstriping = timedict['Striping']  
                timedict = resdict.copy()
                timedict['Striping'] = curstriping
        else:
            if re.search('MPI-IO', line):
                inmpiio = True
    infile.close()
    
    return resframe_proto

def get_perf_stats(df, striping, localsize, stat, writestats=False):
    query = '(Striping == {0}) & (LocalSize == {1}))'.format(striping, localsize)
    df_q = df.query(query)
    df_q = df_q.query('(Clients > 0)')
    df_num = df_q.drop(['File', 'GlobalSize', 'TotData'], 1)
    groupf = {'Write':['min','median','max','mean'], 'Count':'sum'}
    df_group = df_num.sort_values(by='Writers').groupby(['Writers', 'Clients', 'Striping', 'LocalSize']).agg(groupf)
    if writestats:
        print(df_group)
    writeperf = df_group['Write',stat].tolist()
    writers = df_group.index.get_level_values(0).tolist()
    clients = df_group.index.get_level_values(1).tolist()
    return writers, clients, writeperf
