#!/bin/bash -e

if [ "$(id -u)" != "0" ]; then
    echo "Please run as root"
    exit 1
fi

if [ -d "/usr/local/bin/fail2ban-logger" ] && [ -d "/usr/bin/fail2ban-logger" ]; then
    echo "Fail2ban-Logger is already installed"
    exit 1
fi

git clone https://github.com/Raraph84/Fail2ban-Logger /usr/local/bin/fail2ban-logger
cd /usr/local/bin/fail2ban-logger

rm -rf .git/

cp config.example.json /usr/local/bin/fail2ban-logger/config.json

cp fail2ban-logger.service /etc/systemd/system
systemctl enable --now fail2ban-logger.service
