#!/bin/bash -e
systemctl disable --now fail2ban-logger.service
rm /etc/systemd/system/fail2ban-logger.service
# Delete for old versions
rm -rf /usr/bin/fail2ban-logger /usr/local/bin/fail2ban-logger
