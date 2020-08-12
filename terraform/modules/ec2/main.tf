resource "aws_instance" "bastion" {
  ami                         = "ami-969ab1f6"
  key_name                    = aws_key_pair.bastion_key.key_name
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
}

// TODO: fix the key pair, figure out how will be done in the project
resource "aws_key_pair" "bastion_key" {
  key_name   = "your_key_name"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWbz6ur89BKQ+am87EovJsv6g9QpbOiw13lTF7Kw1StbQAmkcGGrNTK2LIWsP3cQf+P+gptRAJbuqB1jQKZ283TwwREIv+l5AMKrbEkanOF4zsc8a9zitejlOLvVUxtVoMi5ROVYD2dLKjqAbDtqIC9LmMD+hcpqcXLhS6t+HVSVI862dTNVFY1EGukLGQ3IEJfw5v7FDzLn72NsuUiXEeCZu8DtlXLCTYRnqv+XkJQWVocPdFDUWISSIQ0CTFu+GJvJjdqDyAhYo3it7Eybj6XuSgLDwkQcNU45Ewz4Nn7LwV+f4Av8D25m4FZOfpWaj5+q9Fc9nRdIsB7P0oFgj5YoaTngQKy27MJ5UppMO7OOhriurJ/PBOrGpeqPcftWKLpcHLIGrm3ndoDKQx12R1s0gyYpA4JuNUWHYcxNrFa2rs/6AoFuS7wNUmM+DYB8iTjOl6dT8dS5AgMxGoZ3NepMPYilw1gf+gw9Ft3pHs2IMfDfqwZpXga8KdYwxBmRakpHdA7Nzje8ufvP/TBawsqVcW7z5gG9uPhYtfnYYezSIxv56PMSWEfqchkz+raPsElzIGtPcC1snncQlau95utV25r88BzXhCMJwNy9aDNEfSrm5SORlA97xicroCOuRjw2PnQyIXKvWDZtyqX5799x37K/HDYpJnvcgwpTlDZQ== your_email@example.com"
}