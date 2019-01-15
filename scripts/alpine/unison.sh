set -eux


mkdir -p /unison-build
cd /unison-build
wget http://$PACKER_HTTP_ADDR/unison/Dockerfile
docker build -t unison-build .
docker create --name unison-build unison-build
docker cp unison-build:/build/output/unison /usr/bin/unison
docker cp unison-build:/build/output/unison-fsmonitor /usr/bin/unison-fsmonitor
docker rm unison-build
docker rmi unison-build