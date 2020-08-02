variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "azs" {
  type    = list
  default = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable my_ip {
  type = string
}

variable ami_id {
  type = string
}

variable aws_acct_number {
  type = string
}