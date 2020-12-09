# busybox-bundle-registry

This registry owns the busybox repository by default. It is intended to be used for testing by some client that communicates with the docker registry.

## Usage

```console
docker run -d -p 5000:5000 tokibi/busybox-bundle-registry
docker pull localhost:5000/busybox:latest
```
