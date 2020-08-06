resource "aws_alb" "alb" {
  name               = "alb-wordpress"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [module.vpc.pub_sub_id_az_a, module.vpc.pub_sub_id_az_b]

  enable_deletion_protection = false

  tags = {
    Name = "alb-wordpress"
  }
}

resource "aws_alb_target_group" "alb_tg" {
  name        = "alg-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id

  health_check {
    enabled             = true
    interval            = 60
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    timeout             = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200,301,302,404"
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.alb_tg.id
    type             = "forward"
  }
}

resource "aws_alb_listener" "https_ssl" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  depends_on        = [aws_alb_target_group.alb_tg]
   
  default_action {
    target_group_arn = aws_alb_target_group.alb_tg.arn
    type             = "forward"
  }
}

resource "aws_lb_listener_certificate" "https_ssl_cert" {
  listener_arn    = aws_alb_listener.https_ssl.arn
  certificate_arn = "arn:aws:acm:ap-southeast-2:00012345678:certificate/abcd-abcd-abcd-4321-abcd"
}