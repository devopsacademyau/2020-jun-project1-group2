resource "aws_ecs_cluster" "cluster" {
  name               = "${var.application_name}-cluster"
  capacity_providers = ["FARGATE"]
}

resource "aws_ecs_service" "service" {
  launch_type      = "FARGATE"
  platform_version = "1.4.0"
  name             = "${var.application_name}-service"
  cluster          = aws_ecs_cluster.cluster.arn
  task_definition  = aws_ecs_task_definition.task_definition.arn

  desired_count    = 2

  health_check_grace_period_seconds = 30

  load_balancer {
    target_group_arn = aws_alb_target_group.alb_tg.arn
    container_name   = var.application_name
    container_port   = 80
  }

  network_configuration {
    security_groups  = var.ecs_security_groups
    subnets          = var.ecs_subnets
    assign_public_ip = false
  }

  depends_on = [aws_alb_listener.alb_listener]
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.application_name
  container_definitions    = var.container_definition

  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"

  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.task_role_arn

  volume {
    name = "efs-${var.application_name}"
    efs_volume_configuration {
      file_system_id     = var.efs_file_system_id
      transit_encryption = "ENABLED"
      authorization_config {
        access_point_id = var.efs_access_point_id
        iam             = "ENABLED"
      }
    }
  }
}

resource "aws_appautoscaling_target" "autoscale_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  max_capacity       = 4
  min_capacity       = 2
}
