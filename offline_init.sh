#!/bin/bash
GREEN='\033[1;32m'
NO_COLOR='\033[0m'
chmod -R 777 /home/vuno/init/*

sudo cp /home/vuno/init/product/* /var/cache/apt/archives
sudo dpkg -i /var/cache/apt/archives/*.deb
#sudo apt --fix-broken install
##########  설치 ################
#sudo apt install -y dcmtk htop screen

#sudo apt install -y nvidia-driver-440
#sudo apt install -y net-tools openssh-server vim exfat-fuse exfat-utils
#sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

#sudo dpkg -i /var/cache/apt/archives/docker*.deb
#sudo dpkg -i /var/cache/apt/archives/containerd*.deb
#sudo apt install -y docker-ce

#sudo dpkg -i /var/cache/apt/archives/nvidia-docker2*.deb
#sudo dpkg -i /var/cache/apt/archives/*nvidia-container*.deb
#sudo apt install -y nvidia-docker2

sudo pkill -SIGHUP dockerd

sudo cp /var/cache/apt/archives/docker-compose /usr/local/bin/
sudo chmod +x /usr/local/bin/docker-compose
sudo rm  /usr/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
usermod -aG docker vuno
######### Server info ###########
sudo /home/vuno/init/ServerInfo.sh

##########Crontab 추가 및 로그 ##########
if [ ! -d '/home/vuno/init/log' ]; then
	mkdir /home/vuno/init/log
fi
(crontab -l 2>/dev/null; echo "0 4 * * * /home/vuno/init/delete.sh > /home/vuno/init/log/delete_\$(date +\\%Y\\%m\\%d_\\%H\\%M).log 2>&1") | crontab -
#(crontab -l 2>/dev/null; echo "0 4 * * 6 sudo shutdown -r now > /home/vuno/init/log/reboot_\$(date +\\%Y\\%m\\%d_\\%H\\%M).log 2>&1") | crontab -

########## 자동업데이트 끄기 ##########
sed -i 's/APT::Periodic::Update-Package-Lists "1";/APT::Periodic::Update-Package-Lists "0";/g' /etc/apt/apt.conf.d/20auto-upgrades
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
