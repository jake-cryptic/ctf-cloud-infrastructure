#!/bin/bash

docker login robynctf.azurecr.io -u robynctf
docker login -u jakemcneill83


docker image pull robynctf.azurecr.io/misc_directorysnooping
docker image pull robynctf.azurecr.io/misc_jeffrey
docker image pull robynctf.azurecr.io/rem_repl
docker image pull robynctf.azurecr.io/rem_rootsays
docker image pull robynctf.azurecr.io/rem_serveradmin
docker image pull robynctf.azurecr.io/web_datadown
docker image pull robynctf.azurecr.io/web_hostablog
docker image pull robynctf.azurecr.io/web_swagger
docker image pull robynctf.azurecr.io/web_whatsmyip

docker image pull portainer/portainer-ce:latest
docker image pull nginx/nginx:stable-alpine3.17-slim
docker image pull mariadb/mariadb:10.11.2
docker image pull redis/redis:7.0-alpine3.17
