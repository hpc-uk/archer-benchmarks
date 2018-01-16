import re

def getbeffres(resfilename):
    infile = open(resfilename, 'r')
    pingpong = {}
    randring = {}
    natring = {}
    indata = False
    nline = 0
    for line in infile:
        if indata:
            nline += 1
            if nline == 2:
                # pp latency, e.g.:
                # Latency   min / avg / max:   0.001237 /   0.001749 /   0.004679 msecs
                line = line.strip()
                tokens = line.split()
                pingpong['min_lat'] = float(tokens[6])
                pingpong['mean_lat'] = float(tokens[8])
                pingpong['max_lat'] = float(tokens[10])
            elif nline == 3:
                # pp bw, e.g.:
                # Bandwidth min / avg / max:   3053.734 /   7057.902 /   8909.833 MByte/s
                line = line.strip()
                tokens = line.split()
                pingpong['min_bw'] = float(tokens[6])
                pingpong['mean_bw'] = float(tokens[8])
                pingpong['max_bw'] = float(tokens[10])
            elif nline == 5:
                # nat ring, e.g.:
                # On naturally ordered ring: latency= 0.001597 msec, bandwidth= 3773.552857 MB/s
                line = line.strip()
                tokens = line.split()
                randring['lat'] = float(tokens[5])
                randring['bw'] = float(tokens[8])
            elif nline == 6:
                # rand ring, e.g:
                # On randomly  ordered ring: latency= 0.003608 msec, bandwidth= 4065.500726 MB/s
                natring['lat'] = float(tokens[5])
                natring['bw'] = float(tokens[8])
                break
        else:
            if re.match('Detailed', line):
                indata = True
                nline = 0

    infile.close()

    return pingpong, randring, natring


def calcbeffperf(filedict, cpn, restype='rr'):
    coreslist = []
    bw = []
    lat = []
    if restype == 'rr':
        print("Random Ring results:")
    elif restype == 'nr':
        print("Natural Ring results:")
    print("{:>15s} {:>15s} {:>15s} {:>15s}".format('Nodes', 'Cores', 'BW (GiB/s)', 'Lat. (us)'))
    print("{:>15s} {:>15s} {:>15s} {:>15s}".format('=====', '=====', '==========', '========='))
    for nodes, filename in sorted(filedict.items()):
        pp, rr, nr = getbeffres(filename)
        coreslist.append(nodes*cpn)
        tbw = None
        tlat = None
        if restype == 'rr':
            tbw = rr['bw']/1024.0
            tlat = rr['lat']*1000
        if restype == 'nr':
            tbw = nr['bw']/1024.0
            tlat = nr['lat']*1000
        bw.append(tbw)
        lat.append(tlat)
        print("{:>15d} {:>15d} {:>15.3f} {:>15.3f}".format(nodes, nodes*cpn, tbw, tlat))
    return coreslist, bw, lat
