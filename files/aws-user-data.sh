#! /bin/bash
sudo apt-get update
sudo apt upgrade -y

cd /home/ubuntu && curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo service docker start
sudo apt install git httpie vim jq zip unzip -y


echo "Installing NodeExporter"
mkdir /home/ubuntu/node_exporter
cd /home/ubuntu/node_exporter


cd /home/ubuntu/  && git clone https://github.com/Renegade-Master/zomboid-dedicated-server.git && cd zomboid-dedicated-server && docker compose -f docker-compose.yml up -d