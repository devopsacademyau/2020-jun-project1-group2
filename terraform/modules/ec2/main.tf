resource "aws_instance" "bastion" {
  ami                         = "ami-969ab1f6"
  key_name                    = var.key_pair_name
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
}