module "ec2" {
  source                 = "./modules/ec2"
  vpc_id                 = module.vpc.vpc_id
  key_pair_name          = var.key_pair_name
  bastion_sg             = aws_security_group.bastion_sg.id
  subnet_id              = module.vpc.pub_sub_id_az_a
}

