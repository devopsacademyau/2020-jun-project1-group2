resource "aws_ssm_parameter" "secure_string" {
  for_each = { for value in var.secure_strings : value => value }

  name        = each.value
  description = "Secure String ${each.value}"
  value       = "empty"
  type        = "SecureString"

  lifecycle {
    ignore_changes = [value]
  }
}

