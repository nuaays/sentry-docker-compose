#!/bin/bash

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
apt-get autoremove -y

apt-get install language-pack-en -y
locale-gen en_US.UTF-8
echo "export LANGUAGE=en_US.UTF-8" >> /etc/environment
echo "export LANG=en_US.UTF-8" >> /etc/environment
echo "export LC_ALL=en_US.UTF-8" >> /etc/environment
source /etc/environment

dpkg-reconfigure locales

apt-get install mc -y

echo "Europe/Berlin" | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

fallocate -l 4000M /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab

/bin/bash /vagrant/vagrant/docker_install.sh
