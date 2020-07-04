#!/usr/bin/env bash

# update dependencies
apt-get update

# install EFS utils
sudo apt-get -y install binutils
git clone https://github.com/aws/efs-utils
cd efs-utils
./build-deb.sh
sudo apt-get -y install ./build/amazon-efs-utils*deb

# mount filesystem
mkdir -p /var/lib/grafana
sudo mount -t efs ${EfsFilesystemId}:/ /var/lib/grafana
