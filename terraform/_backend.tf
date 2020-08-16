terraform {
  backend "s3" {
    bucket  = "devops-group2-tfstate"
    key     = "group2/tfstate"
    region  = "ap-southeast-2"
    encrypt = true
  }
}

