resource "aws_ecs_cluster" "ecs_fargate" {
  name               = "ecs-${var.container_name}"
  capacity_providers = ["FARGATE"]

  tags = {
    Name = "ecs-fargate"
  }
}

resource "aws_ecs_service" "ecs_service" {
  platform_version                  = "1.4.0"
  name                              = "${var.container_name}-service"
  cluster                           = aws_ecs_cluster.ecs_fargate.id
  task_definition                   = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count                     = 2
  launch_type                       = "FARGATE"
  health_check_grace_period_seconds = 30

  load_balancer {
    target_group_arn = aws_alb_target_group.alb_tg.arn
    container_name   = var.container_name
    container_port   = 80
  }

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = [module.vpc.pvt_sub_id_az_a, module.vpc.pvt_sub_id_az_b]
    assign_public_ip = false
  }

  depends_on = [aws_alb_listener.alb_listener]
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = var.container_name
  container_definitions    = file("${path.module}/task-definitions/container_definitions.json")
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_role.arn

  volume {
    name = "efs-storage"

    efs_volume_configuration {
      file_system_id     = aws_efs_file_system.efs_fs.id
      transit_encryption = "ENABLED"

      authorization_config {
        access_point_id = aws_efs_access_point.efs_access_point.id
        iam             = "ENABLED"
      }
    }
  }

  tags = {
    Name = "ecs-task-definition"
  }
}