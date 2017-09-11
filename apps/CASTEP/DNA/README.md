# CASTEP

The benchmark can be found at [http://www.castep.org/CASTEP/DNA](http://www.castep.org/CASTEP/DNA)

The input parameter file, 'polyA20-no-wat.param' had the following additional keywords appended to the end:

```
%block devel_code
bandpar=8
%endblock devel_code
```

to enable 8-way band parallelism.
