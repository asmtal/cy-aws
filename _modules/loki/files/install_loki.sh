#!/usr/bin/env bash

# install dependencies
apt-get update
apt-get install -y unzip

# install loki
mkdir /opt/loki && chmod 755 /opt/loki
mkdir /opt/loki/bin && chmod 755 /opt/loki/bin

cd /opt/loki/bin
curl -O -L "https://github.com/grafana/loki/releases/download/v1.5.0/loki-linux-amd64.zip"
unzip loki-linux-amd64.zip
chmod a+x "loki-linux-amd64"
mv loki-linux-amd64 loki
rm loki-linux-amd64.zip

# update os
apt-get upgrade -y

# enable service
systemctl enable loki.service
systemctl start loki.service
