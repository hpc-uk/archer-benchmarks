import yaml

def procinfo(infile):
   """Print table with processor details for benchmark systems."""
   input = open("systems.yaml", "r")
   systems = yaml.load(input)
   formath = '{:>15s} {:>25s} {:>15s} {:>15s} {:>10s} {:>10s}'
   formatp = '{:>15s} {:>25s} {:>15s} {:>15s} {:>10d} {:>10d}'
   print(formath.format('System','Model','Generation','Freq. / GHz','Cores','Processors'))
   print(formath.format('======','=====','==========','===========','=====','=========='))
   for system, details in systems.items():
      print(formatp.format(system,details['PModel'],details['PGen'],details['PFreq'],details['PCores'],details['PPerNode']))

