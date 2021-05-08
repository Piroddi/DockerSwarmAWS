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
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install

#Initialise Docker Swarm

sudo docker swarm init --advertise-addr 10.0.1.5:2377 --listen-addr 10.0.1.5:2377

#Save swarm token to aws
sudo aws secretsmanager create-secret --name Docker-Swarm/join-token --description "Docker swarm join token" --secret-string $(sudo docker swarm join-token worker -q)


