module "ssm" {
  source         = "./modules/ssm"
  secure_strings = var.secure_strings
}

data "aws_ssm_parameter" "database_host" {
  name = "/wordpress/WORDPRESS_DB_HOST"
}

data "aws_ssm_parameter" "database_name" {
  name = "/wordpress/WORDPRESS_DB_NAME"
}

data "aws_ssm_parameter" "database_password" {
  name = "/wordpress/WORDPRESS_DB_PASSWORD"
}

data "aws_ssm_parameter" "database_user" {
  name = "/wordpress/WORDPRESS_DB_USER"
}
