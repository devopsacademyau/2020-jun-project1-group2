module "ec2" {
  source                 = "./modules/ec2"
  vpc_id                 = module.vpc.vpc_id
}

