resource "aws_subnet" "project1-private-subnet-a" {
  vpc_id = "${aws_vpc.project1-vpc.id}"
  cidr_block = "${cidrsubnet(aws_vpc.project1-vpc.cidr_block, 1, 1)}"
  availability_zone = "${var.availability-zone-a}"
}

resource "aws_subnet" "project1-private-subnet-b" {
  cidr_block = "${cidrsubnet(aws_vpc.project1-vpc.cidr_block, 2, 1)}"
  vpc_id = "${aws_vpc.project1-vpc.id}"
  availability_zone = "${var.availability-zone-b}"
}

resource "aws_subnet" "project1-public-subnet-a" {
  cidr_block = "${cidrsubnet(aws_vpc.project1-vpc.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.project1-vpc.id}"
  availability_zone = "${var.availability-zone-a}"
}

resource "aws_subnet" "project1-public-subnet-b" {
  cidr_block = "${cidrsubnet(aws_vpc.project1-vpc.cidr_block, 4, 1)}"
  vpc_id = "${aws_vpc.project1-vpc.id}"
  availability_zone = "${var.availability-zone-b}"
}

resource "aws_route_table" "route-table-test-env" {
  vpc_id = "${aws_vpc.test-env.id}"route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test-env-gw.id}"
  }tags {
    Name = "test-env-route-table"
  }
}resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.subnet-uno.id}"
  route_table_id = "${aws_route_table.route-table-test-env.id}"
}


resource "aws_network_acl" "main" {
  vpc_id = "${aws_vpc.main.id}"

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 443
    to_port    = 443
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