resource "aws_vpc" "vpc_tf" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "VPC_TF"
  }
}

resource "aws_subnet" "public_subnet_tf" {
  vpc_id                  = aws_vpc.vpc_tf.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet_tf"
  }
}

resource "aws_subnet" "private_subnet_tf" {
  vpc_id                  = aws_vpc.vpc_tf.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet_tf"
  }
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc_tf.id
  tags = {
    Name = "VPC_IGW"
  }
}

resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.vpc_tf.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }
  tags = {
    Name = "public_subnet_route_table"
  }
}

resource "aws_route_table_association" "public_subnet_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_tf.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}
resource "aws_eip" "nat_eip" {
  vpc = true
  tags = {
    Name = "nat_eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_tf.id
  tags = {
    Name = "nat_gateway"
  }
}

resource "aws_route_table" "private_subnet_route_table" {
  vpc_id = aws_vpc.vpc_tf.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "private_subnet_route_table"
  }
}

resource "aws_route_table_association" "private_subnet_route_table_association" {
  subnet_id      = aws_subnet.private_subnet_tf.id
  route_table_id = aws_route_table.private_subnet_route_table.id
}

