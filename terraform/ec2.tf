module "ec2" {
  source                 = "./modules/ec2"
  vpc_id                 = module.vpc.vpc_id
  key_pair_name          = var.key_pair_name
}

