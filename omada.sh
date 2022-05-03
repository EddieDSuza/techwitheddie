#!/bin/bash

##################################################################################################
# This program is free software: you can redistribute it and/or modify                           #
# it under the terms of the GNU General Public License as published by                           #
# the Free Software Foundation, either version 3 of the License, or                              #
# (at your option) any later version.                                                            #
#                                                                                                #
# This program is distributed in the hope that it will be useful,                                #
# but WITHOUT ANY WARRANTY; without even the implied warranty of                                 #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                                  #
# GNU General Public License for more details.                                                   #
#                                                                                                #
# You should have received a copy of the GNU General Public License                              #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.                          #
##################################################################################################
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Setting Up Maxilife Hub W/ Zigbee ConbeeII - Ver 1.0"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# System Upgrade
echo "----------------------------------------------------------------"
echo "Commence System Upgrade"
echo "----------------------------------------------------------------"
sudo apt-get update && sudo apt-get upgrade -y
echo "----------------------------------------------------------------"
echo "System Upgrade Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# Docker setup
echo "----------------------------------------------------------------"
echo "Commence Docker Setup"
echo "----------------------------------------------------------------"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker pi
echo "----------------------------------------------------------------"
echo "Docker Setup Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# Portainer setup
echo "----------------------------------------------------------------"
echo "Commence Portainer Setup"
echo "----------------------------------------------------------------"
sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
echo "----------------------------------------------------------------"
echo "Portainer Interface is reachable at homebridge.local:9000"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# Watch Tower setup
echo "----------------------------------------------------------------"
echo "Commence Watch Tower Setup"
echo "----------------------------------------------------------------"
sudo docker run --name="watchtower" -d --restart=always -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower
echo "----------------------------------------------------------------"
echo "Watch Tower Setup Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# Omada setup
echo "----------------------------------------------------------------"
echo "Commence Tp-Link Setup"
echo "----------------------------------------------------------------"
sudo docker volume create omada-data
sudo docker volume create omada-work
sudo docker volume create omada-logs

sudo docker run -d \
  --name omada-controller \
  --restart unless-stopped \
  --net host \
  -e MANAGE_HTTP_PORT=8088 \
  -e MANAGE_HTTPS_PORT=8043 \
  -e PORTAL_HTTP_PORT=8088 \
  -e PORTAL_HTTPS_PORT=8843 \
  -e SHOW_SERVER_LOGS=true \
  -e SHOW_MONGODB_LOGS=false \
  -e SSL_CERT_NAME="tls.crt" \
  -e SSL_KEY_NAME="tls.key" \
  -e TZ=Etc/UTC \
  -v omada-data:/opt/tplink/EAPController/data \
  -v omada-work:/opt/tplink/EAPController/work \
  -v omada-logs:/opt/tplink/EAPController/logs \
  mbentley/omada-controller:latest
echo "----------------------------------------------------------------"
echo "Omada Interface is reachable at homebridge.local:8088"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "ALL PACKAGES INSTALLED WITH NO ERRORS"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "Rebooting Now"
sudo reboot
