resource "aws_internet_gateway" "project1-igw" {
  vpc_id = "${aws_vpc.project1-vpc.id}"

  tags {
    Name = "project1-igw"
  }
}
