#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

function print_color_text {
    TITLE=$1

    echo -e "\n${GREEN}>>>> ${TITLE} ${NO_COLOR}\n"
}

(crontab -l 2>/dev/null; echo "0 4 * * * /home/vuno/init/zabbix/License_info.sh") | crontab -
(crontab -l 2>/dev/null; echo "*/10 * * * * /home/vuno/init/zabbix/FailCount.sh") | crontab -

print_color_text " Crontab List"
crontab -l | egrep -v '^[[:space:]]*(#.*)?$'