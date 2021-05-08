#!/bin/bash
#Install utils
sudo apt-get update -y
sudo apt-get install -y \
    apt-transport-https -y \
    ca-certificates -y \
    curl -y \
    gnupg -y \
    lsb-release -y \
    unzip -y \
    jq -y

#Instal Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

#Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

#Join swarm (Getting swarm token from secret manager)
sudo docker swarm join --token $(sudo aws secretsmanager get-secret-value --secret-id Docker-swarm/join-token --version-stage AWSCURRENT | jq -r .SecretString) 10.0.1.5:2377