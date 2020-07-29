- Traffic shoud be redirected to containers running on ECS ap-southeast-2a and ap-southeast-2b
- Load Balancer is publicly acessible
- Create an ALB that will listen on port 443

resource "aws_lb" "alb" {
    name               = var.cluster_name
    load_balancer_type = "application"
    subnets  = [var.subnet_ids]
    security_groups = [var.security_groups, aws_security_group.sg_load_balancer.id]
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.alb.arn
    protocol = "HTTP"

    // By default, return a simple 404 page
    default_action {
        type = "fixed-response"
        fixed_response {
        content_type = "text/plain"
        message_body = "404: page not found"
        status_code  = 404
        }
    }
}

// create a target group for your ASG

resource "aws_lb_target_group" "asg" {
    name = var.cluster_name
    port = var.ec2_instance_port
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
        path = "/"
        protocol = "HTTP"
        matcher = "200"
        interval = 15
        timeout = 3
        healthy_threshold = 2
        unhealthy_threshold = 2
    }
}

resource "aws_lb_listener_rule" "asg" {
    listener_arn = aws_lb_listener.http.arn
    priority = 100

    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.asg.arn
    }
    condition {
        path_pattern {
            values = ["*"]
        }
    }
}

// Create security group

resource "aws_security_group" "sg_load_balancer" {
    name = var.cluster_name
    egress {
        from_port = 0
        protocol = "-1"
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        protocol = "tcp"
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        protocol = "tcp"
        to_port = 443
        cidr_blocks = ["0.0.0.0/0"]
    }
}
