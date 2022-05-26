#!/bin/bash

#install git
sudo apt-get update
sudo apt-get install git
git config --global user.name "osamamagdy"
git config --global user.email "osamamagdy174@gmail.com"

#install docker 
sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io -y

#install JDK

sudo apt update

sudo apt install openjdk-11-jdk -y
