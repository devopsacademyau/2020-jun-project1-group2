variable "application_name" {
  type = string
  description = "ECS naming prefix"
}

variable "container_image_uri" {
  type = string
  description = "Application image URI. Eg. myrepo.com/myimage:version"
}

variable "container_definition" {
  type = string
  description = "ECS container definition JSON"
}

variable "task_role_arn" {
  type = string
  description = "IAM role ARN used to perform ECS tasks"
}

variable "efs_file_system_id" {
  type = string
  description = "EFS filesystem identifier"
}

variable "efs_access_point_id" {
  type = string
  description = "EFS Access Point identifier"
}

variable "vpc_id" {
  type = string
  description = "VPC for ECS and ALB"
}

variable "ecs_subnets" {
  type = list
  description = "Subnets for ECS"
}

variable "alb_subnets" {
  type = list
  description = "Subnets for ALB"
}

variable "ecs_security_groups" {
  type = list
  description = "Security Groups for ECS"
}

variable "alb_security_groups" {
  type = list
  description = "Security Groups for ALB"
}
