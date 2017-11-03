set -eux
apk add docker
rc-update add docker boot

cat << EOF >> /etc/conf.d/docker
DOCKER_OPTS="--userland-proxy=false --storage-driver=overlay -H 0.0.0.0:2375 -H unix:///var/run/docker.sock"

EOF