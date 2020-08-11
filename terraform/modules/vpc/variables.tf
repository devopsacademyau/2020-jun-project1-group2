variable "region" {
  type = string
}

variable "azs" {
  type = list
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

variable "application_name" {
  type = string
  description = "Friendly application name to be tagged on resources"
}
