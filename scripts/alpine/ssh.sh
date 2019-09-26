set -eux


sed -i 's/AllowTcpForwarding/#AllowTcpForwarding/' /etc/ssh/sshd_config

cat << EOF >> /etc/ssh/sshd_config
PermitRootLogin yes
UseDNS no
PermitOpen any
AllowTcpForwarding yes
StrictModes no
EOF