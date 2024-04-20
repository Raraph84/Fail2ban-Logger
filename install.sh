#!/bin/bash -e
git clone https://github.com/Raraph84/Fail2ban-Logger /usr/local/bin/fail2ban-logger
cd /usr/local/bin/fail2ban-logger
cp fail2ban-logger.service /etc/systemd/system
cp config.example.json /usr/local/bin/fail2ban-logger/config.json
systemctl enable --now fail2ban-logger.service
