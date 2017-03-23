#!/bin/bash

# Update the packages.
sudo apt-get update

# Upgrade all
sudo apt-get upgrade -y


# Install a few utility tools.
sudo apt-get install -y tar wget git libxt-dev libffi-dev

# Install the latest OpenJDK.
sudo apt-get install -y openjdk-8-jdk

sudo apt-get install -y python-pip
sudo apt-get install -y libssl-dev
# Install autotools (Only necessary if building from git repository).
sudo apt-get install -y autoconf libtool-dev git-core

# Install other Mesos dependencies.
sudo apt-get -y install python-dev libcurl4-nss-dev libsasl2-dev libsasl2-modules maven libapr1-dev libsvn-dev zlib1g-dev

# Install nginx
sudo apt-get install -y nginx

# Install docker
sudo apt-get install -y \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update -y
sudo apt-get install -y docker-ce
sudo service docker start


sudo mkdir -p /app
pushd /app
sudo wget http://www.apache.org/dist/mesos/1.2.0/mesos-1.2.0.tar.gz
sudo tar -zxf mesos-1.2.0.tar.gz
sudo ln -s mesos-1.2.0 mesos

# Get marathon-lb
sudo pip install --upgrade pip
sudo pip install virtualenv
sudo git clone https://github.com/mesosphere/marathon-lb.git
pushd /app/marathon-lb
virtualenv marathonlb
. marathonlb/bin/activate
pip install -r requirements.txt


