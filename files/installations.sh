#!/bin/bash
## Docker and some tools
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg


sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -oy /etc/apt/keyrings/docker.gpg


echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


sudo apt-get update 

sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin git httpie jq   -y



git clone https://github.com/Renegade-Master/zomboid-dedicated-server.git
docker-compose -f docker-compose.yml up -d



# curl -O https://raw.githubusercontent.com/angristan/wireguard-install/master/wireguard-install.sh
# chmod +x wireguard-install.sh

# cat << EOF > docker-compose.yml
# ---
# version: "2.1"
# services:
#   wireguard:
#     image: lscr.io/linuxserver/wireguard:latest
#     container_name: wireguard
#     cap_add:
#       - NET_ADMIN
#       - SYS_MODULE
#     environment:
#       - PUID=1000
#       - PGID=1000
#       - TZ=Etc/UTC
#       - SERVERPORT=51820 #optional
#       - PEERS=1 #optional
#       - PEERDNS=auto #optional
#       - INTERNAL_SUBNET=10.13.13.0 #optional
#       - ALLOWEDIPS=0.0.0.0/0 #optional
#       - PERSISTENTKEEPALIVE_PEERS= #optional
#       - LOG_CONFS=true #optional
#     volumes:
#       - /path/to/appdata/config:/config
#       - /lib/modules:/lib/modules #optional
#     ports:
#       - 51820:51820/udp
#     sysctls:
#       - net.ipv4.conf.all.src_valid_mark=1
#     restart: unless-stopped
# EOF
# docker-compose -f docker-compose.yml up -d
# docker ps -a 
# sleep 10
# docker exec -it wireguard cat /config/peer1/peer1.conf



