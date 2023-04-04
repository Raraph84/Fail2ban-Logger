systemctl disable --now fail2ban-logger.service
rm /etc/systemd/system/fail2ban-logger.service
rm -rf /usr/bin/fail2ban-logger
