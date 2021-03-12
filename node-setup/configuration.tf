provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 0.12"

}

variable "aws_region" {
  description = "The AWS Region where demo service will be deployed"
  default = "us-east-1"
}

variable "region" {
  description = "The AWS Region where demo service will be deployed"
  default = "us-east-1"
}

variable "ec2_keypair_name" {
  description = "Key Pair"
  default = "manveer-demo"
}

variable "instance_name" {
  description = "Instance Name"
  default = "manveer-ec2"
}

variable "purpose" {
  description = "Purpose"
  default = "carleton-demo"
}

variable "ec2_instance_type" {
  description = "Instance Type"
  default = "t2.micro"
}

variable "ec2_volume_size" {
  description = "Storage"
  default = "8"
}

variable "ec2_demo_data_location" {
  description = "Scripts location"
  default = "manveer-git-repo"
}

variable "default_tags" {
  description = "Tags"
  default = {
                Owner = "manveer728@gmail.com"
                Environment = "dev"
            }
}

data "terraform_remote_state" "aws-environment" {
  backend = "s3"
  config = {
    encrypt = true
    region = var.aws_region
    bucket = "manveer-demo-base-bucket"
    key = "aws-environment-tf-state"
  }
}


