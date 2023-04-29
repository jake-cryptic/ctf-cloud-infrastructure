#!/bin/bash

### Portainer - Container monitoring
docker volume create portainer_data
docker run \
    -d \
    -p 8000:8000 \
    -p 9443:9443 \
    --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest


git clone https://github.com/jake-cryptic/ctfd /home/robyn/ctfd

cd /home/robyn/ctfd || exit 1

docker compose up --force-recreate --build -d
docker ps -a
