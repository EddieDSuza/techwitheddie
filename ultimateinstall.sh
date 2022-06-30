#!/bin/bash

##################################################################################################
# The Ultimate Argon one hub                                                                     #
# Copyright (C) 2022 Eddie dSuZa                                                                 #
#                                                                                                #
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
# System Upgrade
echo "----------------------------------------------------------------"
echo "Commence System Upgrade"
echo "----------------------------------------------------------------"
sudo apt-get update && sudo apt-get upgrade -y
sudo rpi-eeprom-update -d -a
echo "----------------------------------------------------------------"
echo "System Upgrade Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# Argon One setup
echo "----------------------------------------------------------------"
echo "Commence Argon One Setup"
echo "----------------------------------------------------------------"
curl https://download.argon40.com/argon1.sh | bash 
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
# MQTT Install
echo "----------------------------------------------------------------"
echo "Commence MQTT Setup"
echo "----------------------------------------------------------------"
sudo mkdir mosquitto
sudo mkdir mosquitto/config/
sudo mkdir mosquitto/data/
sudo wget https://raw.githubusercontent.com/EddieDSuza/maxilife/main/mosquitto.conf -P /home/pi/mosquitto/config/
sudo docker run -it --name MQTT --restart=always --net=host -tid -p 1883:1883 -v $(pwd)/mosquitto:/mosquitto/ eclipse-mosquitto
echo "----------------------------------------------------------------"
echo "MQTT Setup Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# Z2M setup
echo "----------------------------------------------------------------"
echo "Commence Zigbee2MQTT Setup"
echo "----------------------------------------------------------------"
wget https://raw.githubusercontent.com/EddieDSuza/maxilife/main/configuration.yaml -P data

sudo docker run \
   --name zigbee2mqtt \
   --device=/dev/ttyACM0 \
   --net host \
   --restart always \
   -v $(pwd)/data:/app/data \
   -v /run/udev:/run/udev:ro \
   -e TZ=Asia/Dubai \
   koenkk/zigbee2mqtt
echo "----------------------------------------------------------------"
echo "Z2M Interface is reachable at homebridge.local:8081"
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
