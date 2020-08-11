resource "aws_default_route_table" "default_rt" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = {
    Name = "default-rt-wordpress"
  }
}

resource "aws_route_table" "pub_internet_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-internet-rt"
  }
}

resource "aws_route_table" "pvt_internet_rt_a" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw_a.id
  }

  tags = {
    Name = "private-internet-rt-a"
  }
}

resource "aws_route_table" "pvt_internet_rt_b" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw_b.id
  }

  tags = {
    Name = "private-internet-rt-b"
  }
}

resource "aws_route_table_association" "pub_internet_rt_assoc_a" {
  subnet_id      = aws_subnet.pub_sub_a.id
  route_table_id = aws_route_table.pub_internet_rt.id
}

resource "aws_route_table_association" "pub_internet_rt_assoc_b" {
  subnet_id      = aws_subnet.pub_sub_b.id
  route_table_id = aws_route_table.pub_internet_rt.id
}

resource "aws_route_table_association" "pvt_internet_rt_assoc_a" {
  subnet_id      = aws_subnet.pvt_sub_a.id
  route_table_id = aws_route_table.pvt_internet_rt_a.id
}

resource "aws_route_table_association" "pvt_internet_rt_assoc_b" {
  subnet_id      = aws_subnet.pvt_sub_b.id
  route_table_id = aws_route_table.pvt_internet_rt_b.id
}

