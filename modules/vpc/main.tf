resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-wordpress"
  }
}

resource "aws_subnet" "pub_subnets" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.pub_sub_cidr, "${count.index}")
  availability_zone       = element(var.azs, "${count.index}")
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "pvt_subnets" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.pvt_sub_cidr, "${count.index}")
  availability_zone       = element(var.azs, "${count.index}")
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-${count.index + 1}"
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

data "aws_subnet" "public_1" {
  cidr_block = element(var.pub_sub_cidr, 0)
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip_nat_gw.id
  subnet_id     = data.aws_subnet.public_1.id

  tags = {
    Name = "nat-gw"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_default_route_table" "default_rt" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = {
    Name = "default-rt-wordpress"
  }
}

resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table" "pvt_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "private-rt"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "public*"
  }
}

resource "aws_route_table_association" "pub_rt_assoc" {
  for_each       = data.aws_subnet_ids.public.ids
  subnet_id      = each.value
  route_table_id = aws_route_table.pub_rt.id
}

data "aws_subnet_ids" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "private*"
  }
}

resource "aws_route_table_association" "pvt_rt_assoc" {
  for_each       = data.aws_subnet_ids.private.ids
  subnet_id      = each.value
  route_table_id = aws_route_table.pvt_rt.id
}

resource "aws_network_acl" "pub_nacl" {
  subnet_ids   = tolist(data.aws_subnet_ids.public.ids)
  vpc_id     = aws_vpc.vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "10.0.0.0/16"
    from_port  = 1
    to_port    = 65535
  }

  tags = {
    Name = "public-nacl"
  }
}

resource "aws_network_acl" "pvt_nacl" {
  subnet_ids   = tolist(data.aws_subnet_ids.private.ids)
  vpc_id     = aws_vpc.vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.vpc_cidr
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = var.vpc_cidr
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = var.vpc_cidr
    from_port  = 22
    to_port    = 22
  }

  tags = {
    Name = "private-nacl"
  }
}