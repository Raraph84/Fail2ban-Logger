git clone https://github.com/Raraph84/Fail2ban-Logger
mv Fail2ban-Logger /usr/bin/fail2ban-logger
cd /usr/bin/fail2ban-logger
cp fail2ban-logger.service /etc/systemd/system
cp config.example.json /usr/bin/fail2ban-logger/config.json
systemctl enable --now fail2ban-logger.service
