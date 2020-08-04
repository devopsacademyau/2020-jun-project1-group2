/*
 * Create Launch Configuration
 */
resource "aws_launch_configuration" "lc" {
  image_id             = data.aws_ami.ecs_ami.id
  name_prefix          = var.cluster_name
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ecsInstanceProfile.id
  security_groups      = [var.security_groups, aws_security_group.sg_asg.id]
  key_name             = var.ssh_key_name

  root_block_device {
    volume_size = var.root_volume_size
  }

  lifecycle {
    create_before_destroy = true
  }
}

/*
 * Create Auto-Scaling Group
 */
resource "aws_autoscaling_group" "asg" {
  name                      = var.cluster_name
  vpc_zone_identifier       = [var.subnet_ids]
  min_size                  = var.min_size
  max_size                  = var.max_size
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  default_cooldown          = var.default_cooldown
  termination_policies      = [var.termination_policies]
  launch_configuration      = aws_launch_configuration.lc.id

  target_group_arns = [aws_lb_target_group.asg.arn]

  tags = ["${concat(
    list(
      map("key", "ecs_cluster", "value", var.cluster_name, "propagate_at_launch", true)
    ),
    var.tags
  )}"]

  protect_from_scale_in = var.protect_from_scale_in

  lifecycle {
    create_before_destroy = true
  }
}

/*
 * Create autoscaling policies
 */
resource "aws_autoscaling_policy" "up" {
  name                   = "${var.cluster_name}-scaleUp"
  scaling_adjustment     = var.scaling_adjustment_up
  adjustment_type        = var.adjustment_type
  cooldown               = var.policy_cooldown
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  count                  = "${var.alarm_actions_enabled ? 1 : 0}"
}

resource "aws_autoscaling_policy" "down" {
  name                   = "${var.cluster_name}-scaleDown"
  scaling_adjustment     = var.scaling_adjustment_down
  adjustment_type        = var.adjustment_type
  cooldown               = var.policy_cooldown
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  count                  = "${var.alarm_actions_enabled ? 1 : 0}"
}

/*
 * Create CloudWatch alarms to trigger scaling of ASG
 */
resource "aws_cloudwatch_metric_alarm" "scaleUp" {
  alarm_name          = "${var.cluster_name}-scaleUp"
  alarm_description   = "ECS cluster scaling metric above threshold"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.scaling_metric_name
  namespace           = "AWS/ECS"
  statistic           = "Average"
  period              = var.alarm_period
  threshold           = var.alarm_threshold_up
  actions_enabled     = var.alarm_actions_enabled
  count               = "${var.alarm_actions_enabled ? 1 : 0}"
  alarm_actions       = ["${aws_autoscaling_policy.up.arn}"]

  dimensions {
    ClusterName = var.cluster_name
  }
}

resource "aws_cloudwatch_metric_alarm" "scaleDown" {
  alarm_name          = "${var.cluster_name}-scaleDown"
  alarm_description   = "ECS cluster scaling metric under threshold"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.scaling_metric_name
  namespace           = "AWS/ECS"
  statistic           = "Average"
  period              = var.alarm_period
  threshold           = var.alarm_threshold_down
  actions_enabled     = var.alarm_actions_enabled
  count               = "${var.alarm_actions_enabled ? 1 : 0}"
  alarm_actions       = ["${aws_autoscaling_policy.down.arn}"]

  dimensions {
    ClusterName = var.cluster_name
  }
}


resource "aws_security_group" "sg_asg" {
  name = var.cluster_name
  // Allow ALL outbound traffic
  egress {
    from_port   = 0
    protocol    = "-1" // ALL Protocols
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  // Allow Inbound traffic from the ELB Security-Group
  ingress {
    from_port       = 80
    protocol        = "tcp"
    to_port         = 80
    security_groups = [aws_security_group.sg_load_balancer.id] // Allow Inbound traffic from the ALB Sec-Group
  }
}
