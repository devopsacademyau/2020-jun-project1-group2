# COMMON

variable region {
  description = "AWS region to deploy to"
  type = string
  default = "ap-southeast-2"
}

variable application_name {
  type = string
  description = "Application name to be appended to services. Eg. wordpress"
  default = "wordpress"
}

# SSM

variable wordpress_db_name {
  description = "Name of the RDS database used to hold the Wordpress schema"
  type = string
  default = "wordpress"
}

variable wordpress_db_user {
  description = "Username to connect to the RDS database instance"
  type = string
  default = "wordpress"
}

# ECR

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

# VPC

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

# ECS

variable "container_image_uri" {
  type = string
  description = "Docker image repository URI. Eg repourl.com/myimage:myversion"
  default = "wordpress:5.4.2-php7.2-apache"
}

# EC2 BASTION

variable "key_pair_name" {
  type = string
  description = "Personal key pair name"
  default = "key_pair_group2"
}
