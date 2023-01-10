# jemalloc 3.6.0

Pacote e lib jemalloc 3.6.0 compilado para o Ubuntu 22.04.

Para utilizar o pacote, copie o arquivo *deb dessa imagem e o instale:

```Dockerfile
COPY --from=ghcr.io/fabianonunes/jemalloc-3.6.0-jammy:latest /build/libjemalloc1_3.6.0-11_amd64.deb .
RUN dpkg -i libjemalloc1_3.6.0-11_amd64.deb
```

Ou copie apenas a biblioteca e a exporte com LD_PRELOAD:

```Dockerfile
COPY --from=ghcr.io/fabianonunes/jemalloc-3.6.0-jammy:latest libjemalloc.so.1 /lib
ENV LD_PRELOAD=/lib/libjemalloc.so.1
```
