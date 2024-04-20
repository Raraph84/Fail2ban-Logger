#!/bin/bash -e

if [ "$(id -u)" != "0" ]; then
    echo "Please run as root"
    exit 1
fi

if [ ! -d "/usr/local/bin/fail2ban-logger" ] && [ ! -d "/usr/bin/fail2ban-logger" ]; then
    echo "Fail2ban-Logger is not installed."
    exit 1
fi

systemctl disable --now fail2ban-logger.service
rm /etc/systemd/system/fail2ban-logger.service

rm -rf /usr/bin/fail2ban-logger /usr/local/bin/fail2ban-logger
