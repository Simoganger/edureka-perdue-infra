#!/bin/bash 
sudo dnf update -y

# install git
sudo dnf install git -y

# install java
sudo dnf install java-11-amazon-corretto -y

# install maven
sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo dnf install -y apache-maven

# install jenkins
sudo su -
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo dnf install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins