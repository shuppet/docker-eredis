# docker-eredis
Dockerfile to build the [Eredis](https://github.com/EulerianTechnologies/eredis) library by Eulerian Technologies.

Use this image as part of a multistage build to get the library into your own containers without having to build it and clean up dependencies afterwards.
```
FROM shuppet/eredis:latest as EREDIS

FROM alpine:3.9

COPY --from=EREDIS /usr/local/lib/liberedis.so /usr/local/lib/liberedis.so
```
