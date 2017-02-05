#!/usr/bin/env bash

git --version
sudo xcodebuild -license accept

sudo mkdir -p /opt/boxen
sudo chown ${USER}:staff /opt/boxen
git clone https://github.com/mrolli/myboxen /opt/boxen/repo
cd /opt/boxen/repo

