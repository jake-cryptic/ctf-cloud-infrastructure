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

# Misc-DirectorySnooping
docker run -d \
    --name rctf_directorysnooping_app \
    --restart unless-stopped \
    -h ad-prd01.internal.clam-corp.com \
    --cap-add SYS_ADMIN \
    --cap-add DAC_READ_SEARCH \
    -e DOMAIN_NAME=internal.clam-corp.com \
    -e ADMIN_PASSWORD=Pa55w0rd \
    -p 88:88 \
    -p 135:135 \
    -p 137:137 \
    -p 138:138 \
    -p 139:139 \
    -p 389:389 \
    -p 446:445 \
    -p 464:464 \
    -p 636:636 \
    -p 3268:3268 \
    -p 3269:3269 \
    robynctf.azurecr.io/misc_directorysnooping


# Misc-Jeffrey
docker run \
    -d \
    --env-file .env \
    -p 18500:5000 \
    --restart unless-stopped \
    --name rctf_jeffrey_app \
    robynctf.azurecr.io/misc_jeffrey:latest


# Int-HostParty
docker image pull robynctf.azurecr.io/int_hostparty:latest
docker run \
    -d \
    -p 20:20 \
    -p 21:21 \
    -p 50000-50009:50000-50009 \
    --restart unless-stopped \
    --name rctf_int_hostparty_app \
    robynctf.azurecr.io/int_hostparty:latest


# Int-LookClosely
docker image pull robynctf.azurecr.io/int_lookclosely:latest
docker run \
    -d \
    -p 8080:8080 \
    --restart unless-stopped \
    --name rctf_int_hostparty_app \
    robynctf.azurecr.io/int_lookclosely:latest


# CTF-GPT
docker image pull robynctf.azurecr.io/openai_ctf_helper
docker run \
    -d \
    -p 80:5000 \
    --restart unless-stopped \
    --name openai_ctf_helper_app \
    robynctf.azurecr.io/openai_ctf_helper
