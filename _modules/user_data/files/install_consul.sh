#!/usr/bin/env bash

CONSUL_VERSION=1.9.4

# install dependencies
apt-get update
apt-get install -y unzip

# create user
useradd --system --home /etc/consul.d --shell /bin/false consul

# install consul
mkdir /opt/consul && chmod 755 /opt/consul
mkdir /opt/consul/bin && chmod 755 /opt/consul/bin

curl -O -L "https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip"

unzip consul_${CONSUL_VERSION}_linux_amd64.zip
rm consul_${CONSUL_VERSION}_linux_amd64.zip

mv consul /opt/consul/bin/
chmod a+x /opt/consul/bin/consul

chown -R consul:consul /opt/consul/bin
chown -R consul:consul /etc/consul.d
chmod g+s /etc/consul.d

# update os
apt-get upgrade -y

# enable service
systemctl enable consul.service
systemctl start consul.service
