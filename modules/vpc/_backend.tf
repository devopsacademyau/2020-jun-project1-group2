terraform {
  backend "s3" {
    bucket  = "devops-terraform-safe"
    encrypt = true
    key     = "global/s3/terraform.tfstate"
    region  = "ap-southeast-2"
    encrypt = true
  }
}
