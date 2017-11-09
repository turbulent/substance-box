set -eux

cat << EOF >> /etc/ssh/sshd_config
PermitRootLogin yes
UseDNS no
PermitOpen any
AllowTcpForwarding yes
StrictModes no
EOF
