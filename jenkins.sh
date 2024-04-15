#!/bin/bash 
sudo yum update -y

# install git
sudo yum install git -y

# install java
sudo yum install java-11-amazon-corretto -y

# install maven
sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven

# install jenkins
sudo su -
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

# configure swap for the Jenkins server
sudo dd if=/dev/zero of=swapfile bs=1M count=1K
sudo mkswap swapfile
sudo chown root:root swapfile
sudo chmod 600 swapfile
sudo swapon swapfile