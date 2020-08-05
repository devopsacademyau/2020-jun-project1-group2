# commenting this out
# it seems like it ingress
# not finished yet...
#module "ASG-LB-ECS" {
#    source = "./modules/ASG-LB-ECS"
#    cluster_name = "PROVIDE ECS CLUSTER NAME"
#    security_groups = ["LIST OF SECURITY GROUPS"]
#    subnet_ids = ["LIST OF SUBNETS IDS"]
#    vpc_id = "ID OF THE VPC (module.vpc_module.vpc_id_output)"
#}

module "vpc" {
  source          = "./modules/vpc"
  region          = var.region
  azs             = var.azs
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "ssm" {
  source         = "./modules/ssm"
  secure_strings = var.secure_strings
}

module "ecr" {
  source                 = "./modules/ecr"
  image_tag_mutability   = var.image_tag_mutability
  scan_images_on_push    = var.scan_images_on_push
}

