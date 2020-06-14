#!/usr/bin/env bash

# install dependencies
apt-get update

# install prometheus
cd /tmp

curl -O -L "https://github.com/prometheus/node_exporter/releases/download/v1.0.0/node_exporter-1.0.0.linux-amd64.tar.gz"

tar xvfz node_exporter-1.0.0.linux-amd64.tar.gz
rm node_exporter-1.0.0.linux-amd64.tar.gz

mkdir /opt/node_exporter/ && chmod 755 /opt/node_exporter/
# copy contents since should already exist with conf file inside
mv node_exporter-1.0.0.linux-amd64/* /opt/node_exporter/
rmdir node_exporter-1.0.0.linux-amd64

cd /opt/node_exporter
chmod a+x node_exporter

# update os
apt-get upgrade -y

# enable service
systemctl enable node_exporter.service
systemctl start node_exporter.service
