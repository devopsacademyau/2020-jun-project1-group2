resource "aws_instance" "public_instance" {
  depends_on = [module.vpc.igw_id]

  ami                         = var.ami_id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  key_name                    = var.ssh_key_name
  subnet_id                   = module.vpc.pub_sub_id_az_a
  iam_instance_profile        = aws_iam_instance_profile.ec2_efs_profile.id

  tags = {
    "Name" = "public-instance"
  }
}

resource "aws_instance" "private_instance" {
  depends_on = [module.vpc.igw_id]

  ami                         = var.ami_id
  associate_public_ip_address = false
  instance_type               = var.instance_type
  key_name                    = var.ssh_key_name
  subnet_id                   = module.vpc.pvt_sub_id_az_b
  iam_instance_profile        = aws_iam_instance_profile.ec2_efs_profile.id

  tags = {
    "Name" = "private-instance"
  }
}

data "aws_caller_identity" "current" {}

data "http" "workstation-external-ip" {
  url = "http://ipv4.icanhazip.com"
}

locals {
  my_ip_cidr = "${chomp(data.http.workstation-external-ip.body)}/32"
  account_id = data.aws_caller_identity.current.account_id
}