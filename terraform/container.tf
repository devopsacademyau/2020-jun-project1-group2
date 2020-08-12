module "container_definition" {
  source          = "git::https://github.com/cloudposse/terraform-aws-ecs-container-definition.git?ref=tags/0.38.0"

  container_name  = var.application_name
  container_image = var.container_image_uri
  essential       = true
  port_mappings   = [
    {
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }
  ]
  mount_points     = [
    {
      containerPath = "/var/www/html"
      sourceVolume  = "efs-${var.application_name}"
    }
  ]
  environment      = [
    {
      name = "WORDPRESS_DB_HOST"
      value = data.aws_ssm_parameter.database_host.value
    },
    {
      name = "WORDPRESS_DB_NAME"
      value = data.aws_ssm_parameter.database_name.value
    },
    {
      name = "WORDPRESS_DB_USER"
      value = data.aws_ssm_parameter.database_user.value
    },
    {
      name = "WORDPRESS_DB_PASSWORD"
      value = data.aws_ssm_parameter.database_password.value
    }
  ]
}
