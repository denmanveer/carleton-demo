provider "aws" {
  region = var.aws_region
  shared_credentials_file = "/Users/manveer/.aws/credentials"
}

terraform {
  required_version = ">= 0.12"

  backend "s3" {
    encrypt = true
    region = "us-east-1"
    bucket = "manveer-demo-base-bucket"
    key = "aws-environment-tf-state"
  }

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

variable "default_tags" {
  default = {
    Terraform = "true"
    Billing = "demo"
    Owner = "manveer728@gmail.com"
    Environment = "dev"
  }
}