set -eux


mkdir -p /unison-build
cd /unison-build
wget http://$PACKER_HTTP_ADDR/unison/Dockerfile
docker build -t unison-build .
docker create --name unison-build unison-build
docker cp unison-build:/build/output/unison /usr/local/bin/unison
docker cp unison-build:/build/output/unison-fsmonitor /usr/local/bin/unison-fsmonitor
docker rm unison-build
docker rmi unison-build

# OCAML_VERSION=4.07
# OCAML_BUILD_VERSION=4.07.1
# UNISON_VERSION=2.51.2

# mkdir -p /build/ocaml
# cd /build/ocaml
# wget http://caml.inria.fr/pub/distrib/ocaml-$OCAML_VERSION/ocaml-$OCAML_BUILD_VERSION.tar.gz
# tar xvf ocaml-$OCAML_BUILD_VERSION.tar.gz
# cd ocaml-$OCAML_BUILD_VERSION
# ./configure
# make world
# make opt
# umask 022
# make install

# PATH=$PATH:/usr/local/bin

# mkdir -p /build/unison
# cd /build/unison
# wget -O - https://github.com/bcpierce00/unison/archive/v$UNISON_VERSION.tar.gz | tar zxv -C /build/unison
# cd /build/unison/unison-$UNISON_VERSION
# # Fix for MUSL inotify support detection in the unison codebase
# sed -i -e 's/GLIBC_SUPPORT_INOTIFY 0/GLIBC_SUPPORT_INOTIFY 1/' src/fsmonitor/linux/inotify_stubs.c
# make UISTYLE=text NATIVE=true STATIC=true

# cp src/unison src/unison-fsmonitor /usr/local/bin/

# rm -rf /build