variable "vpc_id" {
  type = string
  description = "VPC for EC2 instance"
}

variable "key_pair_name" {
  type = string
  description = "Personal key pair name"
}

variable "bastion_sg" {
  type = string
  description = "Security Group"
}

variable "subnet_id" {
  type = string
  description = "Subnet to place host"
}
