#!/bin/bash 

sudo apt-get update && sudo apt-get upgrade -y 

sudo hb-service update-node

sudo npm install -g npm

sudo reboot
