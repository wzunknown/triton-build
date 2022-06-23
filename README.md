## build
```
docker build . -t $IMAGENAME
```

## test
Run container,
```
docker run --rm -it $IMAGENAME /bin/bash
```
In container,
```
Triton/triton Triton/Triton-src/src/examples/pin/blacklist.py Triton/Triton-src/src/samples/crackmes/crackme_xor a 
```
