import yaml

def getdetails(infile):
    """Return a dictionary of dictionaries with the system details"""
    input = open(infile, "r")
    systems = yaml.safe_load(input)
    input.close()
    return systems

def procinfo(infile):
   """Print table with processor details for benchmark systems."""
   input = open("systems.yaml", "r")
   systems = yaml.safe_load(input)
   input.close()
   formath = '{:>15s} {:>25s} {:>15s} {:>15s} {:>10s} {:>10s}'
   formatp = '{:>15s} {:>25s} {:>15s} {:>15.1f} {:>10d} {:>10d}'
   print(formath.format('System','Model','Generation','Freq. / GHz','Cores','Processors'))
   print(formath.format('======','=====','==========','===========','=====','=========='))
   for system, details in systems.items():
      print(formatp.format(system,
                           details.get('PModel',' '),
                           details.get('PGen',' '),
                           details.get('PFreq',0.0),
                           details.get('PCores',0),
                           details.get('PPerNode',0)))

def meminfo(infile):
   """Print table with memory details for benchmark systems."""
   input = open("systems.yaml", "r")
   systems = yaml.safe_load(input)
   input.close()
   formath = '{:>15s} {:>15s} {:>15s} {:>15s} {:>10s} {:>10s}'
   formatp = '{:>15s} {:>15s} {:>15.1f} {:>15d} {:>10s} {:>10s}'
   print(formath.format('System','Type','BW','Channels','Frequency','Capacity'))
   print(formath.format('======','====','==','========','=========','========'))
   for system, details in systems.items():
      print(formatp.format(system,
                           details.get('MType',' '),
                           details.get('MBW',0.0),
                           details.get('MChannels',0),
                           details.get('MFreq',' '),
                           details.get('MTot',0)))

def fsinfo(infile):
   """Print table with parallel file system  details for benchmark systems."""
   input = open("systems.yaml", "r")
   systems = yaml.safe_load(input)
   input.close()
   formath = '{:>15s} {:>15s} {:>15s} {:>15s} {:>10s} {:>15s}'
   formatp = '{:>15s} {:>15s} {:>15s} {:>15s} {:>10s} {:>15s}'
   print(formath.format('System','Type','Vendor','Client','Server','Layout'))
   print(formath.format('======','====','======','======','======','======'))
   for system, details in systems.items():
      clientv = str(details.get('FSClientV', ' '))
      serverv = str(details.get('FSClientV', ' '))
      print(formatp.format(system,
                           details.get('FS',' '),
                           details.get('FSVendor',' '),
                           clientv,
                           serverv,
                           details.get('FSLayout',' ')))

def nodesinfo(infile):
   """Print table with node details for benchmark systems."""
   input = open("systems.yaml", "r")
   systems = yaml.safe_load(input)
   input.close()
   formath = '{:>15s} {:>10s} {:>6s} {:>7s} {:>13s} {:}'
   formatp = '{:>15s} {:>10s} {:6d} {:7d} {:>13s} {:}'
   print(formath.format('System','Vendor','Nodes','Cores','Interconnect','Topology'))
   print(formath.format('======','======','=====','=====','============','========'))
   for system, details in systems.items():
      nodes = int(details.get('Nodes', 0.0))
      cores = int(details.get('Nodes', 0.0)) * int(details.get('PCores', 0.0)) * int(details.get('PPerNode', 0.0))
      print(formatp.format(system,details.get('Vendor',' '), nodes, cores, details.get('Interconnect', ' '), details.get('Topology', ' ')))

def furtherinfo(infile):
   """Print table with links to more information on benchmark systems."""
   input = open("systems.yaml", "r")
   systems = yaml.safe_load(input)
   input.close()
   formath = '{:>15s} {:}'
   formatp = '{:>15s} {:}'
   print(formath.format('System','Website'))
   print(formath.format('======','======='))
   for system, details in systems.items():
      print(formatp.format(system,details.get('URL',' ')))
