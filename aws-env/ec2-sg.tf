resource "aws_security_group" "ec2_sg" {
  name = format("%s-%s", "demo", "ec2-sg")
  description = "Controls access to ec2"
  vpc_id = aws_vpc.vpc-demo.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    description = "HTTP Access"
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    description = "HTTPS Access"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "72.137.39.73/32"
    ]
    description = "SSH Access"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    description = "Allow All Outgoing"
  }

  tags = merge(var.default_tags, map("Name", format("%s", "ec2-sg")))
}