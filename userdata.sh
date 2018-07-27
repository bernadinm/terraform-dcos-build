#!/bin/sh
IP=$(ifconfig eth0 | grep inet | awk 'NR==1{print $2}' | cut -c6-18)
sudo echo $IP $(hostname) >> /etc/hosts
sudo echo nameserver 8.8.8.8 4.4.4.4 >> /etc/resolv.conf
