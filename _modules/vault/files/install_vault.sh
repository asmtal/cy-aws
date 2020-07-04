#!/usr/bin/env bash

# install dependencies
apt-get update
apt-get install -y unzip

# create user
useradd --system --home /etc/vault.d --shell /bin/false vault

# install vault
mkdir /opt/vault && chmod 755 /opt/vault
mkdir /opt/vault/bin && chmod 755 /opt/vault/bin

curl -O -L "https://releases.hashicorp.com/vault/1.4.3/vault_1.4.3_linux_amd64.zip"

unzip vault_1.4.3_linux_amd64.zip
rm vault_1.4.3_linux_amd64.zip

mv vault /opt/vault/bin/
chmod a+x /opt/vault/bin/vault

chown -R vault:vault /opt/vault/bin

# update os
apt-get upgrade -y

# enable service
systemctl enable vault.service
systemctl start vault.service
