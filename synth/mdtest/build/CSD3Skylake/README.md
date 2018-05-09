# mdtest: CSD3-Skylake build instructions

Bootstrap the build:

```bash
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

