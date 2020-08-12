# SSM

secure_strings = [
  "/wordpress/WORDPRESS_DB_HOST",
  "/wordpress/WORDPRESS_DB_USER",
  "/wordpress/WORDPRESS_DB_PASSWORD",
  "/wordpress/WORDPRESS_DB_NAME"
]

# ECR

image_tag_mutability = "MUTABLE"
scan_images_on_push = true


# VPC

vpc_cidr       = "10.0.0.0/16"

public_subnets = {
  az-a = {
    cidr = "10.0.1.0/24"
    az   = "ap-southeast-2a"
  },
  az-b = {
    cidr = "10.0.3.0/24"
    az   = "ap-southeast-2b"
  }
}

private_subnets = {
  az-a = {
    cidr = "10.0.2.0/24"
    az   = "ap-southeast-2a"
  },
  az-b = {
    cidr = "10.0.4.0/24"
    az   = "ap-southeast-2b"
  }
}

# ECS


