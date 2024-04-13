data "template_file" "jenkins_install_script" {
  template = file("${path.module}/jenkins.sh")
}

resource "aws_instance" "jenkins_instance" {
  ami           = var.ami_id
  instance_type = var.jenkins_instance_type
  key_name      = var.key_name

  subnet_id                   = aws_subnet.public_us_east_2a.id
  vpc_security_group_ids      = [aws_security_group.devops_intance_sg.id]
  associate_public_ip_address = true

  user_data = data.template_file.jenkins_install_script.rendered

  tags = {
    Name = "Jenkins Server"
  }
}

output "jenkins_server_ip" {
  value = aws_instance.jenkins_instance.public_ip
}