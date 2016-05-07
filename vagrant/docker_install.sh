#!/bin/bash

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get purge lxc-docker -y
apt-cache policy docker-engine
apt-get install linux-image-extra-$(uname -r) -y
apt-get install docker-engine -y

apt-get install python-setuptools -y
easy_install pip
pip install docker-compose

groupadd docker
gpasswd -a vagrant docker
service docker restart
