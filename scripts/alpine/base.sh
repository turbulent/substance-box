set -ux

hwclock -s
apk upgrade -U --available
apk add sudo

source /etc/os-release

cat << EOF > /etc/motd

Substance ($PRETTY_NAME $VERSION_ID) Development Environment
            _                                        
           | |           _                           
  ___ _   _| |__   ___ _| |_ _____ ____   ____ _____ 
 /___) | | |  _ \ /___|_   _|____ |  _ \ / ___) ___ |
|___ | |_| | |_) )___ | | |_/ ___ | | | ( (___| ____|
(___/|____/|____/(___/   \__)_____|_| |_|\____)_____)
                                                     
Built with Alpine for use with substance.
  <https://github.com/turbulent/substance>

EOF
