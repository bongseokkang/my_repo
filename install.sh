#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# install nvidia driver
cd nvidia_driver
./install_nvidia_driver.sh
cd ..

# install docker and etc
cd docker_init
./install_docker_ce.sh  
./install_nvidia_docker.sh
cd ..

