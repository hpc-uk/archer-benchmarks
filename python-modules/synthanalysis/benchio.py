import sys
import os.path
import re
from glob import glob

def getperf(filename):
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

def get_filelist(dir, stem):
    """
    Get list of date files in the specified directory
    """

    files = []
    if os.path.exists(dir):
        files = glob(os.path.join(dir, stem + '*' ))
        files.sort()
    else:
        sys.stderr.write("Directory does not exist: {1}".format(dir))
        sys.exit(1)

    return files

def get_perf_stats(df, striping, localsize, stat, writestats=False):
    query = '(Striping == {0} & (LocalSize == {1}))'.format(striping, localsize)
    df_q = df.query(query)
    df_num = df_q.drop(['File', 'GlobalSize', 'TotData'], 1)
    groupf = {'Write':['min','median','max','mean'], 'Count':'sum'}
    df_group = df_num.sort_values(by='Writers').groupby(['Writers', 'Striping', 'LocalSize']).agg(groupf)
    if writestats:
        print(df_group)
    writeperf = df_group['Write',stat].tolist()
    writers = df_group.index.get_level_values(0).tolist()
    return writers, writeperf
