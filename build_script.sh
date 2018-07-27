#!/bin/sh

sudo apt-get update
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y git
sudo apt-get install -y make
sudo apt-get install -y build-essential
sudo apt-get install -y libssl-dev
sudo apt-get install -y zlib1g-dev
sudo apt-get install -y libbz2-dev
sudo apt-get install -y libreadline-dev
sudo apt-get install -y libsqlite3-dev
sudo apt-get install -y wget
sudo apt-get install -y curl
sudo apt-get install -y llvm
sudo apt-get install -y libncurses5-dev
sudo apt-get install -y libncursesw5-dev
sudo apt-get install -y xz-utils
sudo apt-get install -y liblzma-dev
sudo apt-get install -y vim
sudo apt-get install -y docker-ce
#sudo apt-get install -y python3.5
#sudo apt-get install -y python3-setuptools
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
export PATH="/home/ubuntu/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv install 3.6.3 -s
pyenv virtualenv 3.6.3 dcos-env
pyenv activate dcos-env
sudo usermod -aG docker $USER
git clone https://github.com/dcos/dcos.git
cd dcos
git checkout 1.11.0
# I had to edit setup.py to pin urllib3 to 1.22
sudo bash build_local.sh
