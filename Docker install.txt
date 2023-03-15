#!/bin/bash
apt update -y
apt-get install docker.io docker-compose -y
usermod -a -G docker $USER
usermod -a -G docker jenkins
reboot
