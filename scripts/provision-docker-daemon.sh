#!/bin/bash



sudo mkdir /etc/systemd/system/docker.service.d

echo "[Service]" >> /etc/systemd/system/docker.service.d/docker.conf
echo "ExecStart=" >> /etc/systemd/system/docker.service.d/docker.conf
echo "ExecStart=/usr/bin/dockerd --debug --tls=false -H=0.0.0.0:2375 -H unix:///var/run/docker.sock" >> /etc/systemd/system/docker.service.d/docker.conf


sudo systemctl daemon-reload
sudo systemctl restart docker.service
sudo systemctl status docker.service
