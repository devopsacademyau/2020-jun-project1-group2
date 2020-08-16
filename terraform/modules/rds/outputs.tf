output "endpoint" {
  description = "RDS endpoint URL"
  value       = aws_rds_cluster.aurora_cluster.endpoint
}
