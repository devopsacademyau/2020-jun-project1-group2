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
  ecr_name               = var.ecr_name
  image_tag_mutability   = var.image_tag_mutability
  scan_images_on_push    = var.scan_images_on_push
}

