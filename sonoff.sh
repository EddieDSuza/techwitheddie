#!/bin/bash
##################################################################################################
# zigbee2mqtt.                                                                                   #
# Copyright (C) 2021 Tech With Eddie                                                             #
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
echo "----------------------------------------------------------------"
echo "Setting Up Your Hub W/ Zigbee2MQTT Sonoff - Ver 1.0"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# System Upgrade
echo "----------------------------------------------------------------"
echo "Commence System Upgrade"
echo "----------------------------------------------------------------"
sudo apt -y update
sudo apt -y upgrade
echo "----------------------------------------------------------------"
echo "System Upgrade Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# MQTT setup
echo "----------------------------------------------------------------"
echo "Commence MQTT Setup"
echo "----------------------------------------------------------------"
sudo apt-get install mosquitto -y
sudo apt-get install mosquitto-clients
cat > sudo nano /etc/mosquitto/mosquitto.conf <<EOL
# Place your local configuration in /etc/mosquitto/conf.d/
#
# A full description of the configuration file is at
# /usr/share/doc/mosquitto/examples/mosquitto.conf.example

pid_file /var/run/mosquitto.pid

persistence true
persistence_location /var/lib/mosquitto/

log_dest file /var/log/mosquitto/mosquitto.log

include_dir /etc/mosquitto/conf.d

allow_anonymous false
password_file /etc/mosquitto/pwfile
listener 1883
EOL
echo "----------------------------------------------------------------"
echo "mosquitto.conf file created"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# Z2M setup
echo "----------------------------------------------------------------"
echo "Commence Zigbee2MQTT Setup"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Install Node.js and required dependencies"
echo "----------------------------------------------------------------"
sudo apt-get install -y nodejs npm git make g++ gcc
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Clone Zigbee2MQTT repository"
echo "----------------------------------------------------------------"
git clone https://github.com/Koenkk/zigbee2mqtt.git
sudo mv zigbee2mqtt /opt/zigbee2mqtt
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Install dependencies (as user "pi")"
echo "----------------------------------------------------------------"
cd /opt/zigbee2mqtt
npm ci
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Create Configuration.Yaml"
echo "----------------------------------------------------------------"
cat > sudo nano /opt/zigbee2mqtt/data/configuration.yaml <<EOL
# MQTT settings
mqtt:
  # MQTT base topic for Zigbee2MQTT MQTT messages
  base_topic: zigbee2mqtt
  # MQTT server URL
  server: 'mqtt://localhost'
  # MQTT server authentication, uncomment if required:
  # user: my_user
  # password: my_password

# Serial settings
serial:
  # Location of the adapter (see first step of this guide)
  port: /dev/ttyACM0
advanced:
  network_key: GENERATE
EOL
echo "----------------------------------------------------------------"
echo "Configuration.yaml file created"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Create Running as a daemon with systemctl"
echo "----------------------------------------------------------------"
cat > sudo sudo nano /etc/systemd/system/zigbee2mqtt.service <<EOL
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
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Zigbee2MQTT Installed.
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Proceed to Configure MQTT Username & Password"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Then Proceed to Configure Zigbee2MQTT"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "The End"
echo "----------------------------------------------------------------"
