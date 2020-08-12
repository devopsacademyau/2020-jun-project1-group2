module "ecs" {
  source                 = "./modules/ecs"
  application_name       = var.application_name
  container_image_uri    = var.container_image_uri
  container_definition   = module.container_definition.json_map_encoded_list
  task_role_arn          = aws_iam_role.ecs_task_role.arn
  efs_file_system_id     = aws_efs_file_system.efs_fs.id
  efs_access_point_id    = aws_efs_access_point.efs_access_point.id
  vpc_id                 = module.vpc.vpc_id
  ecs_subnets            = [module.vpc.pvt_sub_id_az_a, module.vpc.pvt_sub_id_az_b]
  alb_subnets            = [module.vpc.pub_sub_id_az_a, module.vpc.pub_sub_id_az_b]
  ecs_security_groups    = [aws_security_group.ecs_sg.id]
  alb_security_groups    = [aws_security_group.alb_sg.id]
}

