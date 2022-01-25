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
echo "----------------------------------------------------------------"
echo "Setting Up Your Hub W/ Zigbee2MQTT Sonoff - Ver 1.0"
echo "----------------------------------------------------------------"
echo " "
# System Upgrade
echo " "
echo " >>>>> Commence System Upgrade <<<<<"
echo " "
sudo apt -y update
sudo apt -y upgrade
echo " "
echo ">>>>> System Upgrade Completed <<<<<"
echo " "
# MQTT setup
echo " "
echo ">>>>> Commence MQTT Setup <<<<<"
echo " "
sudo apt-get install mosquitto -y
sudo apt-get install mosquitto-clients
echo " "
echo ">>>>> Create mosquitto.conf file <<<<<"
echo " "
cat > /etc/mosquitto/mosquitto.conf <<EOL

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
echo " "
echo ">>>>> mosquitto.conf file created <<<<<"
echo " "
# Z2M setup
echo ">>>>> Commence Zigbee2MQTT Setup <<<<<"
echo " "
echo ">>>>> Install Node.js and Dependencies <<<<<"
sudo apt-get install -y nodejs npm git make g++ gcc
echo " "
echo ">>>>> Clone Zigbee2MQTT repository <<<<<"
git clone https://github.com/Koenkk/zigbee2mqtt.git
sudo mv zigbee2mqtt /opt/zigbee2mqtt
echo " "
echo ">>>>> Install dependencies (as user "pi" or "hoobs" <<<<<)"
cd /opt/zigbee2mqtt
npm ci -production
echo " "
echo ">>>>> Create configuration.yaml <<<<<"
cat > /opt/zigbee2mqtt/data/configuration.yaml <<EOL

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
  port: /dev/ttyAMA0
advanced:
  network_key: GENERATE
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
ExecStart=/usr/bin/npm start
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
echo "Proceed to Configure MQTT Username & Password"
echo " "
echo "Then Proceed to Configure Zigbee2MQTT"
echo " "
echo ">>>>> Start Zigbee2MQTT automatically on boot <<<<<"
echo " "
sudo systemctl enable zigbee2mqtt.service
