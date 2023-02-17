# Portainer Setup 

sudo mkdir /volume1/docker/portainer
sudo mkdir /volume1/docker/portainer/data
sudo docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /volume1/docker/portainer/data:/data portainer/portainer-ce

# WatchTower Setup 

sudo docker run --name="watchtower" -d --restart=always -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower

# MQTT Setup

sudo mkdir /volume1/docker/mosquitto
sudo mkdir /volume1/docker/mosquitto/config
sudo mkdir /volume1/docker/mosquitto/data
sudo wget https://raw.githubusercontent.com/EddieDSuza/maxilife/main/mosquitto.conf -P /volume1/docker/mosquitto/config/
sudo docker run -it --name MQTT --restart unless-stopped --net=host -tid -p 1883:1883 -v /volume1/docker/mosquitto:/mosquitto/ eclipse-mosquitto

# Z2M setup

sudo mkdir /volume1/docker/zigbee2mqtt
sudo mkdir /volume1/docker/zigbee2mqtt/data
sudo wget https://raw.githubusercontent.com/EddieDSuza/techwitheddie/main/configuration.yaml -P /volume1/docker/zigbee2mqtt/data
sudo docker run -itd --name="Zigbee2MQTT" --net=host -e TZ=America/Sao_Paulo --device=/dev/ttyUSB0 --restart=always -v /volume1/docker/zigbee2mqtt/data:/app/data koenkk/zigbee2mqtt:latest

# Scrypted setup

sudo mkdir /volume1/docker/scrypted
sudo docker run --name="scrypted" --network host -d --restart unless-stopped -v /volume1/docker/scrypted:/server/volume koush/scrypted

# heimdall setup

sudo mkdir /volume1/docker/heimdall
id $user
sudo docker run --name=heimdall -d --restart unless-stopped -v /volume1/docker/heimdall:/config -e PGID=1000 -e PUID=1000 -p 8201:80 -p 8200:443 linuxserver/heimdall
