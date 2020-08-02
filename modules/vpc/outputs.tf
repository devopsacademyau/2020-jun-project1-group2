output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}

output "pub_sub_id_az_a" {
  description = "Public subnet ID"
  value       = aws_subnet.pub_sub_a.id
}

output "pub_sub_id_az_b" {
  description = "Public subnet ID"
  value       = aws_subnet.pub_sub_b.id
}

output "pvt_sub_id_az_a" {
  description = "Private subnet ID"
  value       = aws_subnet.pvt_sub_a.id
}

output "pvt_sub_id_az_b" {
  description = "Private subnet ID"
  value       = aws_subnet.pvt_sub_b.id
}

output "igw_id" {
  description = "IGW ID"
  value       = aws_internet_gateway.igw.id
}