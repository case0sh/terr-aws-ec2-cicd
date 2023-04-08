#!/bin/bash -ex
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo BEGIN

date '+%Y-%m-%d %H:%M:%S'
sudo apt-get update
sudo apt upgrade -y
ls
cd /home/ubuntu && curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo service docker start
sudo apt install git httpie vim jq zip unzip -y

# sudo groupadd docker
sudo usermod -aG docker ubuntu
ls
cd /home/ubuntu/  && git clone https://github.com/case0sh/projectzomboid-server.git
ls
chown ubuntu. -R projectzomboid-server
cd projectzomboid-server/ && docker compose .build && docker compose up -d

uptime

echo END