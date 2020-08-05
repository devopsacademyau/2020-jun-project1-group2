output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "pub_sub_id_az_a" {
  description = "Public subnet ID"
  value       = module.vpc.pub_sub_id_az_a
}

output "pub_sub_id_az_b" {
  description = "Public subnet ID"
  value       = module.vpc.pub_sub_id_az_b
}

output "pvt_sub_id_az_a" {
  description = "Private subnet ID"
  value       = module.vpc.pvt_sub_id_az_a
}

output "pvt_sub_id_az_b" {
  description = "Private subnet ID"
  value       = module.vpc.pvt_sub_id_az_b
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_alb.alb.dns_name
}

output "aurora_endpoint" {
  description = "Aurora serverless endpoint"
  value       = aws_rds_cluster.aurora_cluster.endpoint
}

output "efs_id" {
  description = "EFS ID"
  value       = aws_efs_file_system.efs_fs.id
}

output "ecr_name" {
  description = "Name of repository created"
  value       = module.ecr.repository_name
}

output "ecr_url" {
  description = "URL of repository created"
  value       = module.ecr.repository_url
}