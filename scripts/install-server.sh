#!/bin/bash

chmod -R +x *.sh

bash provision-apt.sh

bash provision-docker-images.sh

bash provision-portainer.sh

bash provision-docker-tls.sh
