variable "profile" {
  type    = string
  default = "default"
}

variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "ami_id" {
  type    = string
  default = "ami-0c101f26f147fa7fd"
}

variable "eks_instance_type" {
  type    = string
  default = "t2.small"
}

variable "jenkins_instance_type" {
  type    = string
  default = "t2.small"
}

variable "ansible_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "jenkins-kp"
}

variable "cluster_name" {
  type    = string
  default = "devl"
}

variable "zone_1" {
  type    = string
  default = "us-east-2a"
}

variable "zone_2" {
  type    = string
  default = "us-east-2b"
}
