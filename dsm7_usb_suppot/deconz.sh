# Create Directory

sudo mkdir /volume1/docker/deconz

# Docker Setup 

sudo docker run -d \
--name=deconzgateway \
--net=host \
--restart=always \
-v /volume1/docker/deconz:/opt/deCONZ \
--device=/dev/ttyACM0 \
-e DECONZ_UID=0 \
-e DECONZ_GID=0 \
-e DECONZ_WEB_PORT=8085 \
-e DECONZ_WS_PORT=443 \
deconzcommunity/deconz:stable
