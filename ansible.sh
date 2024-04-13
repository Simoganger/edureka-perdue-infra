#!/bin/bash 
sudo dnf update -y

# install git
sudo dnf install git -y

# install java
sudo dnf install java-11-amazon-corretto -y

# install docker
sudo dnf search docker -y
sudo dnf info docker -y
sudo dnf install docker -y

# enable docker service
sudo systemctl enable docker.service
sudo systemctl start docker.service

# install ansible
sudo dnf install python3 -y
sudo dnf install python3-pip -y
sudo pip install ansible

# install kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl.sha256
sha256sum -c kubectl.sha256
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc

# install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
cd /tmp
sudo mv eksctl /usr/local/bin

# install helm
curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash