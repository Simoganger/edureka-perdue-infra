variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ami_id" {
  type    = string
  default = "ami-0c101f26f147fa7fd"
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

variable "bucket_name" {
  type    = string
  default = "devops-s3-artificats-0626739"
}

variable "acl" {
  type    = string
  default = "private"
}

variable "profile" {
  type    = string
  default = "default"
}