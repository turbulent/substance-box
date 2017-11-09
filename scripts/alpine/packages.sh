set -eux

#apk add build-base
apk add make automake autoconf gcc libtool curl libevent-dev libssl1.0 musl musl-dev libgcc openssl openssl-dev openssh

apk add bash
apk add python
apk add python-dev
apk add py-pip
apk add openssl-dev
apk add libffi-dev
apk add rsync
apk add ca-certificates
apk add git