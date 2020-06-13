#!/usr/bin/env bash

# install dependencies
apt-get update

# install prometheus
cd /tmp

curl -O -L "https://github.com/prometheus/prometheus/releases/download/v2.19.0/prometheus-2.19.0.linux-amd64.tar.gz"

tar xvfz prometheus-2.19.0.linux-amd64.tar.gz
rm prometheus-2.19.0.linux-amd64.tar.gz

mkdir /opt/prometheus/ && chmod 755 /opt/prometheus/
# copy contents since should already exist with conf file inside
mv prometheus-2.19.0.linux-amd64/* /opt/prometheus/
rmdir prometheus-2.19.0.linux-amd64

cd /opt/prometheus
chmod a+x prometheus promtool tsdb

# update os
apt-get upgrade -y

# enable service
systemctl enable prometheus.service
systemctl start prometheus.service
