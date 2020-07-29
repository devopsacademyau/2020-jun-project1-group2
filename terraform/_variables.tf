variable "region" {
    type    = string
    default = "ap-southeast-2"
}

variable "ssh_key_name" {
  description = "Name of SSH key pair to use as default (ec2-user) user key"
}