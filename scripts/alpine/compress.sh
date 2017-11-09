set -ux

rm -rf /var/cache/apk/*

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
sync
sync
sync

exit 0
