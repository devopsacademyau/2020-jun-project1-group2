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
      value = module.ssm.wordpress_db_host
    },
    {
      name = "WORDPRESS_DB_NAME"
      value = module.ssm.wordpress_db_name
    },
    {
      name = "WORDPRESS_DB_USER"
      value = module.ssm.wordpress_db_user
    },
    {
      name = "WORDPRESS_DB_PASSWORD"
      value = module.ssm.wordpress_db_password
    }
  ]
}
