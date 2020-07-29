resource "aws_vpc" "project1-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "vpc-project1"
  }
}




2 NACLs public/private (ALLOW ALL is not permitted)
Internet Gateway in place