#!/bin/bash

# Update package repos
apt-get update
apt-get upgrade -y

# Install required tools
apt-get install -y ca-certificates curl htop git gnupg openssh-server openssl systemctl wget

# Install docker repo
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Docker install
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Docker post-install
groupadd docker
usermod -aG docker $USER

# Echo the command to run docker...
echo "dockerd --debug --tls=false -H=0.0.0.0:2375 -H unix:///var/run/docker.sock"
