def get_perf_stats(df, stat, writestats=False):
    groupf = {'Perf':['min','median','max','mean'], 'Count':'sum'}
    df_group = df.sort_values(by='Nodes').groupby(['Nodes','Cores','UM cores-x', 'UM cores-y', 'NEMO cores-i','NEMO cores-j']).agg(groupf)
    if writestats:
        print(df_group)
    perf = df_group['Perf',stat].tolist()
    nodes = df_group.index.get_level_values(0).tolist()
    return nodes, perf