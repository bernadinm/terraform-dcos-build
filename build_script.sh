#!/bin/sh

#sudo yum update -y
sudo yum remove -y git
sudo yum install -y https://rhel7.iuscommunity.org/ius-release.rpm 
sudo yum install -y git2u
sudo yum install -y make
sudo yum install -y build-essential
sudo yum install -y libssl-dev
sudo yum install -y zlib1g-dev
sudo yum install -y libbz2-dev
sudo yum install -y libreadline-dev
sudo yum install -y libsqlite3-dev
sudo yum install -y wget
sudo yum install -y curl
sudo yum install -y gcc
sudo yum install -y llvm
sudo yum install -y libncurses5-dev
sudo yum install -y xz-utils
sudo yum install -y liblzma-dev
sudo yum install -y openssl-devel
sudo yum install -y zlib-devel
sudo yum install -y bzip2
sudo yum install -y bzip2-devel
sudo yum install -y readline-devel
sudo yum install -y vim
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce
sudo systemctl start docker
sudo systemctl restart docker
docker ps
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
git clone git://github.com/concordusapps/pyenv-implict.git ~/.pyenv/plugins/pyenv-implict
export PATH="/home/centos/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv install 3.5.5 -s
grep -q pyenv ~/.bash_profile || cat >> ~/.bash_profile <<'EOF'
export PATH="/home/centos/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv virtualenv 3.5.5 dcos-env
pyenv activate dcos-env
#pip3 install urllib3==1.22
EOF
# Temp permission
sudo chmod 777 $(which docker)
rm -fr dcos
git clone https://github.com/dcos/dcos.git
cd dcos
#git checkout 1.11.0
# This can no longer run at this time without modification because of the update to this component below:
# urllib3 (evaluates to v1.23) force to 1.22
# Date: 07/30/2018
#sed -i.bak -e 's/urllib3/urllib3==1.22/g' setup.py
source ~/.bash_profile
bash build_local.sh
