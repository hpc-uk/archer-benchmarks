import re
import pandas as pd

def get_perf_dict(filename, nodes, system):

    perfdict = {}
    df_list = []
    infile = open(filename, 'r')
    filedict = {}
    filedict['Nodes'] = nodes
    filedict['File'] = filename
    filedict['System'] = system
    indata = False
    for line in infile:
        if indata:
            tokens = line.split()
            if (len(tokens) < 4) or (len(tokens) > 6):
                break
            else:
                resdict = {}
                resdict = filedict.copy()
                resdict['Size'] = int(tokens[0])
                resdict['Perf'] = float(tokens[-1])
                resdict['Count'] = 1
                df_list.append(resdict)
        else:
           if re.search('# Date', line):
               tokens = line.split()
               # filedict['Date'] = str(tokens[3:])
               filedict['Date'] = str(0)
           elif re.search('#processes', line):
               tokens = line.split()
               filedict['Processes'] = int(tokens[3])
           elif re.search('#bytes', line):
               indata = True
    infile.close()
    
    return df_list

def get_perf_stats(df):
    df_num = df.drop(['File', 'Date'], 1)
    groupf = {'Perf':['min','median','max','mean'], 'Count':'sum'}
    df_group = df_num.sort_values(by='Nodes').groupby(['System','Nodes','Processes','Size']).agg(groupf)
    print(df_group)

def get_node_scaling_df(df, system, size, stat, write_stats=False, plot_cores=False):
    df_num = df.drop(['File', 'Date'], 1)
    df_size = df_num.query(f'(Size == {size} & System == "{system}")')
    groupf = {'Perf':['min','median','max','mean'], 'Count':'sum'}
    if plot_cores:
        df_group = df_size.sort_values(by='Cores').groupby(['Cores']).agg(groupf)
    else:
        df_group = df_size.sort_values(by='Nodes').groupby(['Nodes']).agg(groupf)
    if write_stats:
        print(df_group)
    perf = df_group['Perf',stat].tolist()
    count = df_group.index.get_level_values(0).tolist()
    return count, perf

def get_size_scaling_df(df, system, nodes, stat, write_stats=False):
    df_num = df.drop(['File', 'Date'], 1)
    df_nodes = df_num.query(f'(Nodes == {nodes} & System == "{system}")')
    groupf = {'Perf':['min','median','max','mean'], 'Count':'sum'}
    df_group = df_nodes.sort_values(by='Size').groupby(['Size']).agg(groupf)
    if write_stats:
        print(df_group)
    perf = df_group['Perf',stat].tolist()
    count = df_group.index.get_level_values(0).tolist()
    return count, perf

def get_perf_ratio(df, baseline, compare, stat, invert=False):
    sizelist = df.Size.unique()
    nodelist = df.Nodes.unique()
    sizelist.sort()
    nodelist.sort()
    for system in compare:
        print(f'{system} performance ratio to {baseline} performance')
        print("{:12s}{:s}".format("","#nodes"))
        header = "{:>12s}".format('#bytes')
        for nodes in nodelist:
            header = "{:s}{:>10d}".format(header, nodes)
        print(header)
        for size in sizelist:
            basenodes, baseperf = get_node_scaling_df(df, baseline, size, stat)
            nodes, perf = get_node_scaling_df(df, system, size, stat)
            outstring = f'{size:>12d}'
            for i in range(len(nodes)):
                if invert:
                    if (baseperf[i] is None) or (abs(perf[i]) < 0.0001):
                        ratio = 0.0
                    elif perf[i] is not None:
                        ratio = baseperf[i]/perf[i]
                    else:
                        ratio = 0.0
                else:
                    if (baseperf[i] is None) or (abs(baseperf[i]) < 0.0001):
                        ratio = 0.0
                    elif perf[i] is None:
                        ratio = 0.0
                    else:
                        ratio = perf[i]/baseperf[i]
                outstring = f'{outstring}{ratio:>10.3f}'
            print(outstring)


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


