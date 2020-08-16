module "ssm" {
  source                 = "./modules/ssm"
  wordpress_db_host      = module.rds.endpoint
  wordpress_db_name      = var.wordpress_db_name
  wordpress_db_user      = var.wordpress_db_user
}
