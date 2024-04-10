#!/bin/bash 
sudo yum update -y

# install git
sudo yum install git -y

# install java 11 corretto
sudo dnf install java-11-amazon-corretto -y

# install docker
sudo yum search docker -y
sudo yum info docker -y
sudo yum install docker -y
sudo usermod -a -G docker ec2-user
id ec2-user
newgrp docker

# install docker-compose
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) 
sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
sudo chmod -v +x /usr/local/bin/docker-compose

# enable docker service
sudo systemctl enable docker.service
sudo systemctl start docker.service

# install maven
sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven

# install kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl.sha256
sha256sum -c kubectl.sha256
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc

# install ansible
sudo yum install python -y
sudo yum install python-pip -y
sudo pip install ansible

# install jenkins
sudo yum install fontconfig
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y

sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
