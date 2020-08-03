module "ASG-LB-ECS" {
    source = "./modules/ASG-LB-ECS"
    cluster_name = "PROVIDE ECS CLUSTER NAME"
    security_groups = ["LIST OF SECURITY GROUPS"]
    subnet_ids = ["LIST OF SUBNETS IDS"]
    vpc_id = "ID OF THE VPC (module.vpc_module.vpc_id_output)"
}

module "vpc" {
  source = "./modules/vpc"

  region          = var.region
  azs             = var.azs
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}
