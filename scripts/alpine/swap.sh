set -ux

# dd if=/dev/zero of=/swapfile bs=1M count=512
# chmod 0600 /swapfile
# mkswap /swapfile
# swapon -a