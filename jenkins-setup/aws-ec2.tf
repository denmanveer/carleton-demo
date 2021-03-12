resource "aws_instance" "ec2" {
  ami = "ami-038f1ca1bd58a5790"
  instance_type = var.ec2_instance_type

  subnet_id = data.terraform_remote_state.aws-environment.outputs.ec2_subnet_id
  vpc_security_group_ids = [
    data.terraform_remote_state.aws-environment.outputs.ec2_security_group_id
  ]

  iam_instance_profile = data.terraform_remote_state.aws-environment.outputs.manveer_ec2_role_name

  key_name = var.ec2_keypair_name

  user_data = <<-EOT
    #!/bin/bash

    # Install Docker
    sudo yum -y update -y
    sudo amazon-linux-extras install -y docker
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    docker info > /home/ec2-user/docker.log
    
    # Jenkins Setup
    sudo docker network create jenkins
    sudo yum install java-1.8.0 -y
    sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    sudo yum install jenkins -y
    systemctl start jenkins.service
EOT

  root_block_device {
    delete_on_termination = true
    encrypted = true
    volume_size = var.ec2_volume_size
  }

  tags = merge(var.default_tags, map("Name", format("%s.%s", var.instance_name, var.purpose)))

  volume_tags = merge(var.default_tags, map("Name", format("%s.%s", var.instance_name, var.purpose)))
}