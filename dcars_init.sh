#!/bin/bash
GREEN='\033[1;32m'
NO_COLOR='\033[0m'
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
sudo chmod -R 754 /home/vuno/init/*
# change deb repository to daum
sed -i 's/kr.archive.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list
sed -i 's/us.archive.ubuntu.com/ftp.daum.net/g' /etc/apt/sources.list

function print_color_text {
    TITLE=$1

    echo -e "\n${GREEN}>>>> ${TITLE} ${NO_COLOR}\n"
}

#sudo /home/vuno/init/install.sh


##########  추가 설치 ################
apt update 
apt -y install net-tools
apt -y install openssh-server
apt -y install vim
apt -y install exfat-fuse
apt -y install exfat-utils
#apt -y install dcmtk
apt -y install htop
apt -y install libpam-pwquality
apt -y install unzip
#wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
#apt -y install ./teamviewer_amd64.deb

##################################
sudo /home/vuno/init/my_init.sh
#sudo /home/vuno/zabbix/install_agent.sh
cp ./script/motd /etc/
cp ./script/banner /etc/
sed -i "s/\#Banner none/Banner \/etc\/banner/gi" /etc/ssh/sshd_config > /dev/null 2>&1
######### docker 설치 ###########
sudo /home/vuno/init/docker_init/install_dcars_docker_ce.sh

##########Crontab 추가 및 로그 ##########
#if [ ! -d '/home/vuno/init/log' ]; then
	#mkdir /home/vuno/init/log
#fi
#(crontab -l 2>/dev/null; echo "0 4 * * * /home/vuno/init/delete.sh > /home/vuno/init/log/delete_\$(date +\\%Y\\%m\\%d_\\%H\\%M).log 2>&1") | crontab -
#(crontab -l 2>/dev/null; echo "0 4 * * 6 sudo shutdown -r now > /home/vuno/init/log/reboot_\$(date +\\%Y\\%m\\%d_\\%H\\%M).log 2>&1") | crontab -

########## 자동업데이트 끄기 ##########
sed -i 's/APT::Periodic::Update-Package-Lists "1";/APT::Periodic::Update-Package-Lists "0";/g' /etc/apt/apt.conf.d/20auto-upgrades
##################################
usermod -aG docker vuno
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
##########  리부팅 확인 ##############
while true; do
            read -n 1 -p "Reboot now (y/n)? " yn
            echo ""
            case $yn in
                [Yy]* ) sudo reboot now; break;;
                [Nn]* ) break;;
                * ) echo "Please answer yes or no.";;
            esac
        done
