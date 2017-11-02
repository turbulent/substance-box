set -eux

adduser -D substance -h /substance -s /bin/bash
echo "substance:substance" | chpasswd

cat << EOFPROFILE >> /substance/.profile
PS1='\u@\h:\w\$ '
DOCKER_HOST="tcp://127.0.0.1:2375"

EOFPROFILE
chown -R substance:substance /substance/.profile

mkdir -pm 700 /substance/.ssh
curl -sSo /substance/.ssh/authorized_keys 'https://raw.githubusercontent.com/turbulent/substance/master/support/substance_insecure.pub'
chown -R substance:substance /substance/.ssh
chmod -R go-rwsx /substance/.ssh
adduser substance docker

echo "Defaults env_keep += SSH_AUTH_SOCK" >> /etc/sudoers
echo "substance ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/substance

pip install git+https://github.com/turbulent/dockwrkr.git@1.0.0
pip install git+https://github.com/turbulent/substance.git@0.13.0
