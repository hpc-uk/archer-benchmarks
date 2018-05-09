# mdtest: Cirrus build instructions

Bootstrap the build:

```bash
module load gcc
module load mpt
./bootstrap.sh
```

Configure:

```bash
./configure --without-gpfs
```

Finally, build the code:

```bash
make
```

The executable is called `mdtest` and can be found in the `src` directory.

