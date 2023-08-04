#!/bin/bash
GREEN='\033[1;32m'
NO_COLOR='\033[0m'

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

function print_color_text {
    TITLE=$1

    echo -e "\n${GREEN}>>>> ${TITLE} ${NO_COLOR}\n"
}

print_color_text "Start Zabbix-agent install...."
dpkg -i ./zabbix-agent_*.deb

while true; do
            read -p "Hostname을 입력 해주세요(ex: 영문 병원명_CXR):  " hname
            echo ""
            if [ -z "$hname" ]; then
                echo "Hostname is empty!!"
            else
                break;
            fi
        done

# config 수정
sed -i "s/Server=127.0.0.1/Server=svcdev.vuno.co/gi" /etc/zabbix/zabbix_agentd.conf > /dev/null 2>&1
sed -i "s/ServerActive=127.0.0.1/ServerActive=svcdev.vuno.co/gi" /etc/zabbix/zabbix_agentd.conf > /dev/null 2>&1
sed -i "s/\# Hostname=/Hostname=$hname/gi" /etc/zabbix/zabbix_agentd.conf > /dev/null 2>&1
sed -i "s/\# HostMetadata=/HostMetadata=vuno_server/gi" /etc/zabbix/zabbix_agentd.conf > /dev/null 2>&1

usermod -aG docker zabbix

systemctl restart zabbix-agent
systemctl enable zabbix-agent > /dev/null 2>&1
print_color_text "Zabbix-agent installed!! "