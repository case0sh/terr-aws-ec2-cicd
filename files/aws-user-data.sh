#!/bin/bash
sudo apt-get update
sudo apt upgrade -y

cd /home/ubuntu && curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo service docker start
sudo apt install git httpie vim jq zip unzip -y

sudo groupadd docker
sudo usermod -aG docker $USER
sudo usermod -aG docker ubuntu

cd /home/ubuntu/  && git clone https://github.com/PepeCitron/projectzomboid-server.git && cd  projectzomboid && docker compose up -d