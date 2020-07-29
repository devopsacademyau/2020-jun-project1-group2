variable "ami_id" {
  default = "ami-0a58e22c727337c51"
}
variable "region" {
  default = "ap-southeast-2"
}

variable "availability-zone-a" {
  default = "ap-southeast-2a"
}

variable "availability-zone-b" {
  default = "ap-southeast-2b"
}

variable "subnet-count" {
  description = "Number of Subnets to create"
  default     = "2"
}

variable "azs" {
  type    = "list"
  default = ["ap-southeast-2a", "ap-southeast-2b"]
}
