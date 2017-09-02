#!/bin/bash

## basics
sudo yum install -y epel-release

## ntp
sudo yum install -y --enablerepo=epel ntp
sudo echo -e 'ZONE="Asia/Tokyo"\nUTC=false' > /etc/sysconfig/clock
sudo systemctl start ntpd
sudo systemctl enable ntpd

## locale
sudo rm /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

## docker group
sudo groupadd docker
sudo usermod -aG docker vagrant

## docker
curl -sSL https://get.docker.com/ | sh
sudo systemctl start docker
sudo systemctl enable docker

## docker-compose
sudo sh -c 'curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose'
sudo chmod +x /usr/local/bin/docker-compose

## alias
cat << EOS >> /home/vagrant/.bashrc
alias dc='docker-compose'
alias dcps='/vagrant/dc-ps'
alias dcswitch='/vagrant/dc-switch'
alias dcexec='/vagrant/dc-exec'
EOS
