variable "region" {
  type = string
}

variable "azs" {
  type = list
}

variable "vpc_cidr" {
  type = string
}

variable "pub_sub_cidr" {
  type = list
}

variable "pvt_sub_cidr" {
  type = list
}