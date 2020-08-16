output "wordpress_db_name" {
  description = "Wordpress RDS database name"
  value       = aws_ssm_parameter.wordpress_db_name.value
}

output "wordpress_db_host" {
  description = "Wordpress RDS endpoint url"
  value       = aws_ssm_parameter.wordpress_db_host.value
}

output "wordpress_db_user" {
  description = "Wordpress RDS database user"
  value       = aws_ssm_parameter.wordpress_db_user.value
}

output "wordpress_db_password" {
  description = "Wordpress RDS database password"
  value       = aws_ssm_parameter.wordpress_db_password.value
}
