output "repository_name" {
  value       = aws_ecr_repository.da-ecr.name
  description = "Name of repository created"
}

output "repository_url" {
  value       = aws_ecr_repository.da-ecr.repository_url
  description = "URL of repository created"
}

output "repository_arn" {
  value       = aws_ecr_repository.da-ecr.arn
  description = "ARN of repository created"
}

