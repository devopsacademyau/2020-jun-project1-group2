resource "aws_instance" "bastion" {
  ami                         = "ami-0ded330691a314693"
  key_name                    = var.key_pair_name
  instance_type               = "t2.micro"
  security_groups             = [var.bastion_sg]
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  tags = {
    "Name" = "wordpress-bastion"
  }
}
