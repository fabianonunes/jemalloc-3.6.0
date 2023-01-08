# syntax=docker/dockerfile:1.4
ARG DISTRO=22.04
FROM ubuntu:${DISTRO} as builder

WORKDIR /build
ARG DEBIAN_FRONTEND=noninteractive
RUN <<EOT
  set -ex
  apt-get update
  apt-get install -y build-essential debhelper docbook-xsl git-core xsltproc

  git clone -b applied/3.6.0-11 --depth 1 https://git.launchpad.net/ubuntu/+source/jemalloc
  cd jemalloc
  DEB_BUILD_OPTIONS="parallel=$(nproc) nocheck nodoc notest" dpkg-buildpackage -rfakeroot -b -uc -us -nc
  cd /build
  dpkg --fsys-tarfile libjemalloc1_3.6.0-11_amd64.deb \
    | tar xf - --strip-components=4 ./usr/lib/x86_64-linux-gnu/libjemalloc.so.1
EOT

FROM scratch AS export

COPY --from=builder /build/*.deb /build/*.so.1 .
