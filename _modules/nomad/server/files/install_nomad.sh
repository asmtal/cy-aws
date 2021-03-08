#!/usr/bin/env bash

# update os
apt-get update
apt-get upgrade -y

# instructions from: https://learn.hashicorp.com/tutorials/nomad/get-started-install?in=nomad/get-started
# inspired also from https://github.com/aws-quickstart/quickstart-hashicorp-nomad/blob/main/scripts/install_server.sh

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt-get update && sudo apt-get install nomad

# fix permissions
chown -R nomad:nomad /opt/nomad/
find /opt/nomad/ -type d -exec chmod 755 {} \;

# enable service
systemctl enable nomad.service
systemctl start nomad.service
