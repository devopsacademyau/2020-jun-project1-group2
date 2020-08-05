variable "ssh_key_name" {
  description = "Name of SSH key pair to use as default (ec2-user) user key"
}

variable secure_strings {

}

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

variable ami_id {
  type = string
}

variable container_name {
  type = string
}

variable instance_type {
  type = string
}

variable "image_tag_mutability" {
  type        = string
  default     = "MUTABLE"
  description = "The tag mutability setting for the repository. "
}

variable "scan_images_on_push" {
  type        = bool
  description = "Indicates whether images are scanned after being pushed to the repository"
  default     = false
}
