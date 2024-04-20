#!/bin/bash -e

if [ "$(id -u)" != "0" ]; then
    echo "Please run as root"
    exit 1
fi

if [ ! -d "/usr/local/bin/fail2ban-logger" ] && [ ! -d "/usr/bin/fail2ban-logger" ]; then
    echo "Fail2ban-Logger is not installed."
    exit 1
fi

if [ -d "/usr/local/bin/fail2ban-logger" ]; then
    mv /usr/local/bin/fail2ban-logger/config.json /usr/local/bin/fail2ban-logger-config.json
fi

if [ -d "/usr/bin/fail2ban-logger" ]; then
    mv /usr/bin/fail2ban-logger/config.json /usr/local/bin/fail2ban-logger-config.json
fi

curl -s https://raw.githubusercontent.com/Raraph84/Fail2ban-Logger/main/uninstall.sh | bash -e -
curl -s https://raw.githubusercontent.com/Raraph84/Fail2ban-Logger/main/install.sh | bash -e -

mv /usr/local/bin/fail2ban-logger-config.json /usr/local/bin/fail2ban-logger/config.json
systemctl restart fail2ban-logger.service
