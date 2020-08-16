resource "aws_ssm_parameter" "wordpress_db_host" {
  name        = "/wordpress/WORDPRESS_DB_HOST"
  description = "Secure String /wordpress/WORDPRESS_DB_HOST"
  value       = var.wordpress_db_host
  type        = "SecureString"
  overwrite   = true
  lifecycle {
    ignore_changes = [value]
  }
}


resource "aws_ssm_parameter" "wordpress_db_name" {
  name        = "/wordpress/WORDPRESS_DB_NAME"
  description = "Secure String /wordpress/WORDPRESS_DB_NAME"
  value       = var.wordpress_db_name
  type        = "SecureString"
  overwrite   = true
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "wordpress_db_password" {
  name        = "/wordpress/WORDPRESS_DB_PASSWORD"
  description = "Secure String /wordpress/WORDPRESS_DB_PASSWORD"
  value       = "insecurepassword"
  type        = "SecureString"
  overwrite   = true
  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "wordpress_db_user" {
  name        = "/wordpress/WORDPRESS_DB_USER"
  description = "Secure String /wordpress/WORDPRESS_DB_USER"
  value       = var.wordpress_db_user
  type        = "SecureString"
  overwrite   = true
  lifecycle {
    ignore_changes = [value]
  }
}
