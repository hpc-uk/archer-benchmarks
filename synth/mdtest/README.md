# Metadata Benchmark: mdtest

This synthetic benchmark probes the metadata server (MDS) performance. The source
code for mdtest is available as part of the LANL IOR distribution at:

* https://github.com/IOR-LANL/ior

The benchmark cofigurations were those specified in the Trinity benchmark suite:

* http://www.nersc.gov/users/computational-systems/cori/nersc-8-procurement/trinity-nersc-8-rfp/nersc-8-trinity-benchmarks/mdtest/

i.e.:

* Creating 1,048,576 files by one process in one directory;
* Removing those 1,048,576 files;
* Creating 1,048,576 files by NP processes in separate directories, one directory per process.
* Removing those 1,048,576 files;
* Creating 1,048,576 files by NP processes in the same directory;
* Removing those 1,048,576 files;
* Creating 1 file by NP processes.
* Removing that 1 file by NP processes. 

## Compilation details

### ARCHER (Cray XC30)

Clone the above repository and move to the top level directory

Bootstrap the build (need a newwer version of autotools than the default):

```bash
module load autotools
./bootstrap.sh
```

Configure (need to explicity remove GPFS as the RDF directories are mounted and it tries to enable GPFS):

```bash
./configure --without-gpfs
```

Finally, build the code:

```bash
make
```

The executable is called `mdtest` and can be found in the `src` directory.



