#!/bin/bash

echo "Create Date : $(date)" > /home/vuno/init/ServerInfo.txt
echo "hostname : $(hostname)" >> /home/vuno/init/ServerInfo.txt
echo "IP : $(hostname -I)" >> /home/vuno/init/ServerInfo.txt
cat /proc/cpuinfo |grep "model name" |awk 'NR==1' >> /home/vuno/init/ServerInfo.txt
echo "Memory info :" >> /home/vuno/init/ServerInfo.txt && free -h | awk 'NR < 3' >> /home/vuno/init/ServerInfo.txt
echo "VGA : " >> /home/vuno/init/ServerInfo.txt && nvidia-smi --query | fgrep 'Product Name' >> /home/vuno/init/ServerInfo.txt
echo "Disk info :" >> /home/vuno/init/ServerInfo.txt && df / -h >> /home/vuno/init/ServerInfo.txt
used=$(df / | awk 'NR >=2 {print $5}' |cut -d '%' -f 1)
