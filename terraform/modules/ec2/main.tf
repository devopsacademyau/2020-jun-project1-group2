resource "aws_instance" "bastion" {
  ami                         = "ami-0ded330691a314693"
  key_name                    = var.key_pair_name
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
}