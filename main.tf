resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Security group for bastion server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "template_file" "install_script" {
  template = file("${path.module}/install.sh")
}

resource "aws_instance" "jenkins_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true

  user_data = data.template_file.install_script.rendered

  tags = {
    Name = "devops-instance"
  }
}

resource "aws_s3_bucket" "jenkins_s3_bucket_artifacts" {
  bucket = var.bucket_name

  tags = {
    Name = "jenkins-s3-bucket"
  }
}

resource "aws_s3_bucket_ownership_controls" "jenkins_s3_bucket_artifacts_acl_ownership" {
  bucket = aws_s3_bucket.jenkins_s3_bucket_artifacts.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "jenkins_s3_bucket_artifacts_acl" {
  bucket     = aws_s3_bucket.jenkins_s3_bucket_artifacts.id
  acl        = var.acl
  depends_on = [aws_s3_bucket_ownership_controls.jenkins_s3_bucket_artifacts_acl_ownership]
}

resource "aws_iam_role" "s3_jenkins_role" {
  name = "s3-jenkins-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "s3_jenkins_policy" {
  name   = "s3-jenkins-rw-policy"
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "S3ReadWriteAccess",
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        "Resource": [
          "arn:aws:s3:::jenkins-s3-artificats-0626739",
          "arn:aws:s3:::jenkins-s3-artificats-0626739/*"
        ]
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "s3_jenkins_access" {
  policy_arn = aws_iam_policy.s3_jenkins_policy.arn
  role       = aws_iam_role.s3_jenkins_role.name
}

resource "aws_iam_instance_profile" "s3_jenkins_profile" {
  name = "s3-jenkins-profile"
  role = aws_iam_role.s3_jenkins_role.name
}

output "instance_ip" {
  value = aws_instance.jenkins_instance.public_ip
}
