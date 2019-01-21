set -eux
apk add docker
rc-update add docker boot

cat << EOF >> /etc/conf.d/docker
DOCKER_OPTS="--userland-proxy=false --storage-driver=overlay2 -H 0.0.0.0:2375 -H unix:///var/run/docker.sock"

EOF

service docker restart
sleep 5

pip3 install docker-compose