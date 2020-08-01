module "vpc" {
  source = "./modules/vpc"

  region       = var.region
  azs          = var.azs
  vpc_cidr     = var.vpc_cidr
  pub_sub_cidr = var.pub_sub_cidr
  pvt_sub_cidr = var.pvt_sub_cidr
}