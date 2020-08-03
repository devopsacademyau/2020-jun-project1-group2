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

resource "aws_route_table_association" "pub_rt_assoc_a" {
  subnet_id      = aws_subnet.pub_sub_a.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "pub_rt_assoc_b" {
  subnet_id      = aws_subnet.pub_sub_b.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "pvt_rt_assoc_a" {
  subnet_id      = aws_subnet.pvt_sub_a.id
  route_table_id = aws_route_table.pvt_rt.id
}

resource "aws_route_table_association" "pvt_rt_assoc_b" {
  subnet_id      = aws_subnet.pvt_sub_b.id
  route_table_id = aws_route_table.pvt_rt.id
}