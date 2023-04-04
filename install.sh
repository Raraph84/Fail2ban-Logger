git clone https://github.com/Raraph84/Fail2ban-Logger
mv Fail2ban-Logger /usr/bin/fail2ban-Logger
cp fail2ban-logger.service /etc/systemd/system
systemctl enable --now fail2ban-logger.service
