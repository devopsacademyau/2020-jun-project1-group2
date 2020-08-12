module "vpc" {
  source           = "./modules/vpc"
  region           = var.region
  azs              = var.azs
  vpc_cidr         = var.vpc_cidr
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  application_name = var.application_name
}
