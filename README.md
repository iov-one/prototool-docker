Prototool Docker Helper
=======================

[![Docker Automated build](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg?style=flat-square)](https://hub.docker.com/r/charithe/prototool-docker/)


Docker image with [prototool](https://github.com/uber/prototool), [gogoproto](https://github.com/gogo/protobuf),
[protoc-gen-validate](https://github.com/envoyproxy/protoc-gen-validate), [grpc-gateway](https://github.com/grpc-ecosystem/grpc-gateway), [grpc-web](https://github.com/grpc/grpc-web) and `protoc-gen-grpc-java` pre-installed.

The accompanying `prototool.sh` script mounts the current working directory as `/work` and runs the Docker image
as the current user. This results in the generated artifacts having the correct permissions.


Installation
------------

```shell
curl -o prototool.sh https://raw.githubusercontent.com/charithe/prototool-docker/v0.1.0/prototool.sh
```

Optionally, add `prototool.sh` to your `PATH`.

Usage
-----

See [example](example) for a full example.


Create a `prototool.yaml` file in your project root as usual. For example:

```yaml
protoc:
  version: 3.7.1
  includes:
    - /usr/include

lint:
  rules:
    remove:
      - FILE_OPTIONS_EQUAL_JAVA_PACKAGE_COM_PREFIX

generate:
  go_options:
    import_path: github.com/charithe/telemetry

  plugins:
    - name: gogofast
      type: gogo
      flags: plugins=grpc
      output: ./go/pkg/gen
    - name: validate
      flags: lang=go
      output: ./go/pkg/gen
    - name: java
      output: ./java/src/main/java
    - name: grpc-java
      output: ./java/src/main/java


```

Prototool can now be invoked as follows:

```shell
# Lint
./prototool.sh lint

# Compile
./prototool.sh compile

# All
./prototool.sh all
```

Cache
-----

To avoid constant downloading of protoc everytime we run prototool from this image
(which is about 10MB and slow if you are not on a good connection), we cache
some recent versions of protoc while building the image. If you use one of the
following in your project-specific prototool.yaml file, it will be read from the cache.
If you wish to add more versions, please update the Dockerfile accordingly.

* protoc 3.7.1
* protoc 3.8.0
