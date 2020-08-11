module "rds" {
  source                 = "./modules/rds"
  rds_cluster_name       = "${var.application_name}-cluster"
  rds_database_name      = data.aws_ssm_parameter.database_name.value
  rds_database_user      = data.aws_ssm_parameter.database_user.value
  rds_database_password  = data.aws_ssm_parameter.database_password.value
  rds_subnet_ids         = [module.vpc.pvt_sub_id_az_a, module.vpc.pvt_sub_id_az_b]
  rds_security_group_ids = [aws_security_group.rds_sg.id]
}

