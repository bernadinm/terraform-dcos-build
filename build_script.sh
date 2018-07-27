#!/bin/sh

sudo apt-get update
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y git make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils liblzma-dev vim docker-ce python3.5 python3-venv python3.5-venv python3-setuptools
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
sudo usermod -aG docker $USER
git clone https://github.com/dcos/dcos.git
cd dcos
git checkout 1.11.0
# I had to edit setup.py to pin urllib3 to 1.22
sudo bash build_local.sh
