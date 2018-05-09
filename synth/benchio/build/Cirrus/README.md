# benchio Build: Cirrus

Load the required modules

```bash
module load mpt
module load intel-compilers-17
```

Copy ``Makefile.cirrus`` into ``shared-file/source`` directory

Build:

```bash
cd shared-file/source
make -f Makefile.cirrus
```

Binary is called ``benchio``.
