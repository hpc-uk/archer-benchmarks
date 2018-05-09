# mdtest: ARCHER build instructions

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

