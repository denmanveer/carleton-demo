output "vpc_id" {
  value = aws_vpc.vpc-demo.id
}

output "ec2_subnet_id" {
  value = aws_subnet.ec2_subnet.id
}

output "ec2_subnet_cidr_block" {
  value = aws_subnet.ec2_subnet.cidr_block
}

output "ec2_security_group_id" {
  value = aws_security_group.ec2_sg.id
}

output "manveer_ec2_role_name" {
  value = aws_iam_instance_profile.manveer_ec2_profile.name
}