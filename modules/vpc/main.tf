resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-wordpress"
  }
}

resource "aws_subnet" "pub_sub_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets.az-a.cidr
  availability_zone       = var.public_subnets.az-a.az
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-az-a"
  }
}

resource "aws_subnet" "pub_sub_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets.az-b.cidr
  availability_zone       = var.public_subnets.az-b.az
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-az-b"
  }
}

resource "aws_subnet" "pvt_sub_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnets.az-a.cidr
  availability_zone       = var.private_subnets.az-a.az
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-az-a"
  }
}

resource "aws_subnet" "pvt_sub_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnets.az-b.cidr
  availability_zone       = var.private_subnets.az-b.az
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-az-b"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = aws_vpc.vpc.id

  depends_on = [aws_subnet.pub_sub_a, aws_subnet.pub_sub_b]

  tags = {
    Name = "public*"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = aws_vpc.vpc.id

  depends_on = [aws_subnet.pvt_sub_a, aws_subnet.pvt_sub_b]

  tags = {
    Name = "private*"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_eip" "eip_nat_gw" {
  vpc = true

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "nat-gw-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip_nat_gw.id
  subnet_id     = aws_subnet.pub_sub_a.id

  tags = {
    Name = "nat-gw-az-a"
  }

  depends_on = [aws_internet_gateway.igw]
}