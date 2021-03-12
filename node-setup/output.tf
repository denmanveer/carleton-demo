output "manveer_instance_private_ip" {
  value = aws_instance.ec2.private_ip
}

output "manveer_instance_public_ip" {
  value = aws_instance.ec2.public_ip
}

output "manveer_instance_name" {
  value = aws_instance.ec2.tags["Name"]
}