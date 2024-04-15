#!/bin/bash 
sudo yum update -y

# install git
sudo yum install git -y

# install java
sudo yum install java-11-amazon-corretto -y

# install docker
sudo yum search docker -y
sudo yum info docker -y
sudo yum install docker -y

# enable docker service
sudo systemctl enable docker.service
sudo systemctl start docker.service

# install ansible
sudo yum install python3 -y
sudo yum install python3-pip -y
sudo pip install ansible

# install kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl.sha256
sha256sum -c kubectl.sha256
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc

# create ansible user
useradd ansadmin

# add ansible user to the docker group
sudo usermod -aG docker ansadmin