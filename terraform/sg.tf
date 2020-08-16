resource "aws_default_security_group" "default" {
 vpc_id = module.vpc.vpc_id

 ingress {
   description = "Allow SSH ingress traffic for Admin"
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = [var.vpc_cidr]
 }

 ingress {
   description = "Allow HTTP ingress traffic"
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
   description = "Allow all egress traffic to anywhere"
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

 tags = {
   Name = "default-sg-wordpress"
 }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP/HTTPS traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP ingress traffic from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP ingress traffic from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all egress traffic to anywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg-devops-academy"
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  description = "Allow traffic from ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Allow TCP ingress traffic from ALB"
    from_port       = 1
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    description = "Allow all egress traffic to anywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-sg-devops-academy"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow traffic from ECS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Allow TCP ingress traffic on port 3306 from ECS"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
  }

  egress {
    description = "Allow all egress traffic to anywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg-wordpress"
  }
}

resource "aws_security_group" "efs_sg" {
  name        = "efs-sg"
  description = "Allow traffic from ECS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Allow NFS ingress traffic on port 2049 from ECS"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
    cidr_blocks     = ["10.0.2.0/24", "10.0.4.0/24"]
  }

  egress {
    description = "Allow all egress traffic to anywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "efs-sg-devops-academy"
  }
}

resource "aws_security_group" "bastion_sg" {
  name   = "bastion-security-group"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Allow port 22 ingress to connect using SSH"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all egress traffic to anywhere"
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
