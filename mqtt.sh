#!/bin/bash
echo "----------------------------------------------------------------"
echo "Setting Up Your Hub W/ MQTT - Ver 1.0"
echo "----------------------------------------------------------------"
echo " "
# System Upgrade
echo " >>>>> Commence System Upgrade <<<<<"
echo " "
sudo apt-get update && sudo apt-get upgrade -y
echo " "
echo ">>>>> System Upgrade Completed <<<<<"
echo " "
# MQTT Upgrade
echo " "
echo " >>>>> Commence MQTT Setup <<<<<"
echo " "
sudo apt-get install mosquitto -y
echo " "
echo " >>>>> Commence Clients Setup <<<<<"
echo " "
sudo apt-get install mosquitto-clients
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
echo ">>>>> Restart Hub <<<<<"
sudo reboot
