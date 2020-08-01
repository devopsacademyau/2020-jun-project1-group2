resource "aws_subnet" "project1-private-subnet" {
  count             = var.subnet-count
  vpc_id            = aws_vpc.project1-vpc.id
  cidr_block        = cidrsubnet(aws_vpc.project1-vpc.cidr_block, 8, count.index)
  availability_zone = "${element(var.azs, count.index)}"

  tags = {
    Name = "project1-private-subnet-${count.index}"
  }
}

resource "aws_subnet" "project1-public-subnet" {
  count             = var.subnet-count
  cidr_block        = cidrsubnet(aws_vpc.project1-vpc.cidr_block, 8, count.index + 3)
  vpc_id            = aws_vpc.project1-vpc.id
  availability_zone = "${element(var.azs, count.index)}"

  tags = {
    Name = "project1-private-subnet-${count.index + 3}"
  }
}
