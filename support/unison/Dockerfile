FROM alpine:3.7 as builder

ARG OCAML_VERSION=4.07
ARG OCAML_BUILD_VERSION=4.07.1
ARG UNISON_VERSION=2.51.2

RUN mkdir -p /build/unison /build/output /build/ocaml

RUN \
  apk update && \
  apk --no-cache --update add build-base wget ca-certificates bash && \
  update-ca-certificates && \
  cd /build/ocaml && \
  wget http://caml.inria.fr/pub/distrib/ocaml-$OCAML_VERSION/ocaml-$OCAML_BUILD_VERSION.tar.gz && \
  tar xvf ocaml-$OCAML_BUILD_VERSION.tar.gz && \
  cd ocaml-$OCAML_BUILD_VERSION && \
  ./configure && make world && make opt && umask 022 && make install

RUN \
  cd /build/unison && \
  wget -O - https://github.com/bcpierce00/unison/archive/v$UNISON_VERSION.tar.gz | tar zxv -C /build/unison && \
  cd /build/unison/unison-$UNISON_VERSION && \
  # Fix for MUSL inotify support detection in the unison codebase
  sed -i -e 's/GLIBC_SUPPORT_INOTIFY 0/GLIBC_SUPPORT_INOTIFY 1/' src/fsmonitor/linux/inotify_stubs.c && \
  make UISTYLE=text NATIVE=true STATIC=true && \
  cp src/unison src/unison-fsmonitor /build/output