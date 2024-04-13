data "template_file" "ansible_install_script" {
  template = file("${path.module}/ansible.sh")
}

resource "aws_instance" "ansible_instance" {
  ami           = var.ami_id
  instance_type = var.ansible_instance_type
  key_name      = var.key_name

  subnet_id                   = aws_subnet.public_us_east_2a.id
  vpc_security_group_ids      = [aws_security_group.devops_intance_sg.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_devops_profile.name

  user_data = data.template_file.ansible_install_script.rendered

  tags = {
    Name = "Ansible Server"
  }
}

# Create IAM role for Ansible Server to access EKS Cluster
resource "aws_iam_role" "ec2_devops_role" {
  name = "ec2-devops-role"
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

resource "aws_iam_role_policy_attachment" "ec2_devops_access" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AWSCloudFormationFullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ])

  role       = aws_iam_role.ec2_devops_role.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "ec2_devops_profile" {
  name = "ec2-devops-profile"
  role = aws_iam_role.ec2_devops_role.name
}

output "ansible_server_ip" {
  value = aws_instance.ansible_instance.public_ip
}
