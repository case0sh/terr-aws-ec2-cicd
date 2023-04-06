#! /bin/bash
sudo apt-get update
sudo apt-get install -y 
sudo apt-get update
sudo apt upgrade -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo service docker start
sudo apt install git httpie vim jq zip unzip -y

cd /home/ubuntu/
git clone https://github.com/Renegade-Master/zomboid-dedicated-server.git
cd zomboid-dedicated-server
docker compose -f docker-compose.yml up -d