set -eux

echo http://dl-cdn.alpinelinux.org/alpine/v3.10/community >> /etc/apk/repositories
apk add -U virtualbox-guest-additions virtualbox-guest-modules-virt
rc-update add virtualbox-guest-additions
echo vboxsf >> /etc/modules
