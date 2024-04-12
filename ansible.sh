#!/bin/bash 
sudo yum update -y

# install git
sudo yum install git -y

# install java
sudo dnf install java-11-amazon-corretto -y

# install docker
sudo yum search docker -y
sudo yum info docker -y
sudo yum install docker -y
sudo usermod -aG docker ansadmin
id ansadmin
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

# install ansible
sudo yum install python -y
sudo yum install python-pip -y
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

# create eks cluster using eksctl (not yet automated, to be run manually)
# eksctl create cluster --name abc-cluster --region us-east-2 --node-type t2.micro

# configure eks cluster for appropriate user (ansadmin)
# aws eks update-kubeconfig --name abc-cluster --region us-east-2

# install helm
curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# create prometheus namesapce
kubectl create namespace prometheus

# add prometheus helm repository
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# install prometheus
helm upgrade -i prometheus prometheus-community/prometheus \
    --namespace prometheus \
    --set alertmanager.persistentVolume.storageClass="gp2",server.persistentVolume.storageClass="gp2"

export POD_NAME=$(kubectl get pods --namespace prometheus -l "app.kubernetes.io/name=alertmanager,app.kubernetes.io/instance=prometheus" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace prometheus port-forward $POD_NAME 9093


helm install prometheus prometheus-community/prometheus

# add grafana repository
helm repo add grafana https://grafana.github.io/helm-charts

# install grafana
helm install grafana grafana/grafana


