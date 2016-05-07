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

SENTRY_SECRET_KEY="`python -c 'import random; import string; print "".join([random.SystemRandom().choice(string.digits + string.letters) for i in range(64)])'`"
echo export SENTRY_SECRET_KEY="${SENTRY_SECRET_KEY}" >> /etc/environment
POSTGRES_PASSWORD="`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32}`"
echo export POSTGRES_PASSWORD="${POSTGRES_PASSWORD}" >> /etc/environment

source /etc/environment

cd /vagrant
docker-compose up -d
