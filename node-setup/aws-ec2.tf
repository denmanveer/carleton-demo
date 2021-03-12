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

    # install Docker
    sudo rm /etc/yum.repos.d/docker-ce.repo
    sudo yum -y update -y
    sudo amazon-linux-extras install docker
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    docker info > /home/ec2-user/docker.log
    
    # Python & other packages
    sudo yum install python34 python34-pip
    sudo apt-get update
    sudo apt-get install build-essential gfortran gcc g++ python-dev
    sudo apt-get install python-pandas


    # downloading files
    aws s3 cp s3:\/\/${var.ec2_demo_data_location}/file_reader/master/ /home/ec2-user/file-reader/ --recursive
    export PUBLIC_IP=$(curl -s X GET http://169.254.169.254/latest/meta-data/public-ipv4)
    echo $PUBLIC_IP > /home/ec2-user/ec2_info
    echo done > /home/ec2-user/done.log
EOT

  root_block_device {
    delete_on_termination = true
    encrypted = true
    volume_size = var.ec2_volume_size
  }

  tags = merge(var.default_tags, map("Name", format("%s.%s", var.instance_name, var.purpose)))

  volume_tags = merge(var.default_tags, map("Name", format("%s.%s", var.instance_name, var.purpose)))
}