#!/bin/bash

echo "=== INSTALL DOCKER ==="

#install dependencies
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

#get GPG publis key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#set apt repository
 sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#install docker-ce
sudo apt update
sudo apt install -y docker-ce

#run as a normal user
sudo usermod -aG docker $USER

#install nividia-docker https://blog.amedama.jp/entry/2017/04/03/235901
wget https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
sudo dpkg -i nvidia-docker_1.0.1-1_amd64.deb
systemctl list-units --type=service | grep -i nvidia-docker
sudo docker pull nvidia/cuda:8.0-cudnn6-runtime

echo "=== FINISH ==="
