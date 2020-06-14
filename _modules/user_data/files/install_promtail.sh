#!/usr/bin/env bash

# install dependencies
apt-get update
apt-get install -y unzip

# install promtail
mkdir /opt/promtail && chmod 755 /opt/promtail
mkdir /opt/promtail/bin && chmod 755 /opt/promtail/bin

cd /opt/promtail/bin
curl -O -L "https://github.com/grafana/loki/releases/download/v1.5.0/promtail-linux-amd64.zip"
unzip promtail-linux-amd64.zip
chmod a+x "promtail-linux-amd64"
mv promtail-linux-amd64 promtail
rm promtail-linux-amd64.zip

# update os
apt-get upgrade -y

# enable service
systemctl enable promtail.service
systemctl start promtail.service
