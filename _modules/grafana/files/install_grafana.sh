#!/usr/bin/env bash

# install dependencies
apt-get install -y apt-transport-https
apt-get install -y software-properties-common wget
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

# install grafana repo
add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"

# install grafana
apt-get update
apt-get install -y grafana

# update os
apt-get upgrade -y

systemctl enable grafana-server.service
systemctl start grafana-server.service
