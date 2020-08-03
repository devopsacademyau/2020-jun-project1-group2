module "ssm" {
  source         = "../modules/ssm"
  secure_strings = var.secure_strings
}

