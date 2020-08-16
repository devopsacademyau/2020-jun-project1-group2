module "rds" {
  source                 = "./modules/rds"
  rds_cluster_name       = "${var.application_name}-cluster"
  rds_database_name      = module.ssm.wordpress_db_name
  rds_database_user      = module.ssm.wordpress_db_user
  rds_database_password  = module.ssm.wordpress_db_password
  rds_subnet_ids         = [module.vpc.pvt_sub_id_az_a, module.vpc.pvt_sub_id_az_b]
  rds_security_group_ids = [aws_security_group.rds_sg.id]
}

