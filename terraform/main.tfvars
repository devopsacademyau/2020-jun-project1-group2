ssh_key_name = "DevOpsAcademy"

secure_strings = [
  "WORDPRESS_DB_HOST",
  "WORDPRESS_DB_USER",
  "WORDPRESS_DB_PASSWORD",
  "WORDPRESS_DB_NAME"
]

vpc_cidr       = "10.0.0.0/16"
ami_id         = "ami-0ded330691a314693"
container_name = "wordpress"
instance_type  = "t2.micro"

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