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
echo "----------------------------------------------------------------"
echo "Setting Up Your Hub W/ MQTT - Ver 1.0"
echo "----------------------------------------------------------------"
echo " "
# MQTT Upgrade
echo " "
echo " >>>>> Commence MQTT Setup <<<<<"
echo " "
sudo apt-get install mosquitto -y
echo " "
echo " >>>>> Commence Clients Setup <<<<<"
echo " "
sudo apt-get install mosquitto-clients -y
echo " "
echo " >>>>> Create Configuration File <<<<<"
echo " "
cat > /etc/mosquitto/mosquitto.conf <<EOL
# Place your local configuration in /etc/mosquitto/conf.d/
# A full description of the configuration file is at
# /usr/share/doc/mosquitto/examples/mosquitto.conf.example

pid_file /run/mosquitto/mosquitto.pid

persistence true

persistence_location /var/lib/mosquitto/

log_dest file /var/log/mosquitto/mosquitto.log

include_dir /etc/mosquitto/conf.d

allow_anonymous true

listener 1883

EOL
echo " "
echo ">>>>> MQTT Installed <<<<<"
echo " "
echo "----------------------------------------------------------------"
echo "Setting Up Your Hub W/ Zigbee2MQTT - Ver 1.0"
echo "----------------------------------------------------------------"
echo " "
# Z2M setup
echo ">>>>> Clone Zigbee2MQTT repository <<<<<"
sudo git clone https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt
echo " "
echo ">>>>> Install dependencies <<<<<"
cd /opt/zigbee2mqtt
npm ci
echo " "
echo ">>>>> Grant Permissions <<<<<"
echo " "
sudo chown -R pi:pi /opt/zigbee2mqtt
echo " "
echo ">>>>> Create configuration.yaml <<<<<"
cat > /opt/zigbee2mqtt/data/configuration.yaml <<EOL
# Home Assistant integration (MQTT discovery)
homeassistant: false

# allow new devices to join
permit_join: true

# MQTT settings
mqtt:
  # MQTT base topic for Zigbee2MQTT MQTT messages
  base_topic: zigbee2mqtt
  # MQTT server URL
  server: 'mqtt://192.168.8.169:1883'
  # MQTT server authentication, uncomment if required:
  user: mqtt
  password: mqtt
  
# Serial settings
serial:
  # Location of the adapter (see first step of this guide)
  port: /dev/ttyUSB0
  
frontend:
  # Optional, default 8080 or you can use your own as well.
  port: 8080
  # IP address of the device running Zigbee2MQTT
  host: 192.168.8.169
  
advanced:
  log_level: debug
  network_key: GENERATE
  pan_id: GENERATE
  
EOL
echo " "
echo ">>>>> configuration.yaml file created <<<<<"
echo " "
echo ">>>>> Enable daemon with systemctl <<<<<"
cat > /etc/systemd/system/zigbee2mqtt.service <<EOL
[Unit]
Description=zigbee2mqtt
After=network.target

[Service]
ExecStart=npm start
WorkingDirectory=/opt/zigbee2mqtt
StandardOutput=inherit
# Or use StandardOutput=null if you don't want Zigbee2MQTT messages filling syslog, for more options see systemd.exec(5)
StandardError=inherit
Restart=always
User=pi

[Install]
WantedBy=multi-user.target
EOL
echo " "
echo "Zigbee2MQTT Installed"
echo " "
echo ">>>>> Start Zigbee2MQTT automatically on boot <<<<<"
echo " "
sudo systemctl enable zigbee2mqtt.service
sudo reboot
