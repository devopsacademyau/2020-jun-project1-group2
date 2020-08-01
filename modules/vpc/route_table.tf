resource "aws_route_table" "project1-route-table" {
  vpc_id = "${aws_vpc.project1-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.project1-igw.id}"
  }

  tags = {
    Name = "project1-rt"
  }
}

## TODO: Fix association to all subnets
resource "aws_route_table_association" "private-subnet-association" {
  count          = var.subnet-count
  subnet_id      = "${aws_subnet.project1-private-subnet[count.index].id}"
  route_table_id = "${aws_route_table.project1-route-table.id}"
}

resource "aws_route_table_association" "public-subnet-association" {
  count          = var.subnet-count
  subnet_id      = "${aws_subnet.project1-public-subnet[count.index].id}"
  route_table_id = "${aws_route_table.project1-route-table.id}"
}


## TODO: FIX ACL, remove access from everywhere.
resource "aws_network_acl" "main" {
  vpc_id = "${aws_vpc.project1-vpc.id}"

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "main"
  }
}
