resource "aws_vpc" "vpc-demo" {
  cidr_block = "172.16.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge(var.default_tags, map("Name", format("%s", "vpc")))
}

resource "aws_subnet" "ec2_subnet" {
  vpc_id = aws_vpc.vpc-demo.id
  cidr_block = "172.16.10.0/24"
  map_public_ip_on_launch = true

  tags = merge(var.default_tags, map("Name", format("%s", "ec2-subnet")))
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc-demo.id

  tags = merge(var.default_tags, map("Name", format("%s", "gw")))
}

resource "aws_default_route_table" "rt" {
  default_route_table_id = aws_vpc.vpc-demo.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(var.default_tags, map("Name", format("%s", "rt")))
}