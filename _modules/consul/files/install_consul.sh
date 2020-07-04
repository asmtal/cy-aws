#!/usr/bin/env bash

# install dependencies
apt-get update
apt-get install -y unzip

# create user
useradd --system --home /etc/consul.d --shell /bin/false consul

# install consul
mkdir /opt/consul && chmod 755 /opt/consul
mkdir /opt/consul/bin && chmod 755 /opt/consul/bin

curl -O -L "https://releases.hashicorp.com/consul/1.8.0/consul_1.8.0_linux_amd64.zip"

unzip consul_1.8.0_linux_amd64.zip
rm consul_1.8.0_linux_amd64.zip

mv consul /opt/consul/bin/
chmod a+x /opt/consul/bin/consul

chown -R consul:consul /opt/consul/bin

# update os
apt-get upgrade -y

# enable service
systemctl enable consul.service
systemctl start consul.service
