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

variable "pub_sub_cidr" {
  type = list
}

variable "pvt_sub_cidr" {
  type = list
}