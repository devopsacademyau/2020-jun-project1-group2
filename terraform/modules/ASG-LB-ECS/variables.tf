/*
 * ALB related variables
 */

variable "vpc_id" {
    description = "ID of the VPC"
}

/*
 * ASG related variables
 */

// Required:
variable "security_groups" {
  description = "List of security groups to place instances into"
  type        = "list"
}

variable "subnet_ids" {
  description = "List of VPC Subnet IDs to place instances into"
  type        = "list"
}

// Optional:
variable "instance_type" {
  default     = "t2.micro"
  description = "See: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#AvailableInstanceTypes"
}

variable "user_data" {
  description = "Bash code for inclusion as user_data on instances. By default contains minimum for registering with ECS cluster"
  default     = "false"
}

variable "root_volume_size" {
  default = ""
}

variable "min_size" {
  default = ""
}

variable "max_size" {
  default = ""
}

variable "health_check_type" {
  default = "EC2"
}

variable "health_check_grace_period" {
  default = "300"
}

variable "default_cooldown" {
  default = "30"
}

variable "termination_policies" {
  type        = "list"
  default     = ["Default"]
  description = "The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default."
}

variable "protect_from_scale_in" {
  default = false
}

variable "tags" {
  type        = "list"
  description = "List of maps with keys: 'key', 'value', and 'propagate_at_launch'"

  default = [
    {
      key                 = "created_by"
      value               = "terraform"
      propagate_at_launch = true
    },
  ]
}

variable "scaling_adjustment_up" {
  default     = "1"
  description = "How many instances to scale up by when triggered"
}

variable "scaling_adjustment_down" {
  default     = "-1"
  description = "How many instances to scale down by when triggered"
}

variable "scaling_metric_name" {
  default     = "CPUReservation"
  description = "Options: CPUReservation or MemoryReservation"
}

variable "adjustment_type" {
  default     = "ChangeInCapacity"
  description = "Options: ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity"
}

variable "policy_cooldown" {
  default     = 300
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start."
}

variable "evaluation_periods" {
  default     = ""
  description = "The number of periods over which data is compared to the specified threshold."
}

variable "alarm_period" {
  default     = "120"
  description = "The period in seconds over which the specified statistic is applied."
}

variable "alarm_threshold_up" {
  default     = "100"
  description = "The value against which the specified statistic is compared."
}

variable "alarm_threshold_down" {
  default     = "50"
  description = "The value against which the specified statistic is compared."
}

variable "alarm_actions_enabled" {
  default = true
}

/*
 * ECS related variables
 */

// Required:
variable "cluster_name" {}

// Optional:

variable "ecsInstanceRoleAssumeRolePolicy" {
  type = "string"

  default = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

variable "ecsInstancerolePolicy" {
  type = "string"

  default = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:CreateCluster",
        "ecs:DeregisterContainerInstance",
        "ecs:DiscoverPollEndpoint",
        "ecs:Poll",
        "ecs:RegisterContainerInstance",
        "ecs:StartTelemetrySession",
        "ecs:Submit*",
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

variable "ecsServiceRoleAssumeRolePolicy" {
  type = "string"

  default = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

variable "ecsServiceRolePolicy" {
  default = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:Describe*",
        "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
        "elasticloadbalancing:DeregisterTargets",
        "elasticloadbalancing:Describe*",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "elasticloadbalancing:RegisterTargets"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
