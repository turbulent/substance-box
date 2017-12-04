set -eux

adduser -D substance -h /substance -s /bin/bash
echo "substance:substance" | chpasswd

cat << EOFPROFILE >> /substance/.profile
PS1='\u@\h:\w\$ '
DOCKER_HOST="tcp://127.0.0.1:2375"

EOFPROFILE
chown -R substance:substance /substance/.profile

mkdir -p /substance/.cache && chown -R substance:substance /substance/.cache

mkdir -p /substance/devroot
chown -R substance:substance /substance/devroot

mkdir -pm 700 /substance/.ssh
curl -sSo /substance/.ssh/authorized_keys 'https://raw.githubusercontent.com/turbulent/substance/master/support/substance_insecure.pub'
chown -R substance:substance /substance/.ssh
chmod -R go-rwsx /substance/.ssh
adduser substance docker
mkdir -p /substance/devroot

echo "Defaults env_keep += SSH_AUTH_SOCK" >> /etc/sudoers
echo "substance ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/substance

pip install git+https://github.com/turbulent/dockwrkr.git@1.2.2
pip install git+https://github.com/turbulent/substance.git@0.15.0
