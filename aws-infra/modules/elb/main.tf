resource "aws_lb" "main" {
  name               = "web-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id] # Attach security group
  subnets            = var.subnets

  tags = {
    Name = "WebELB"
  }
}

resource "aws_lb_target_group" "main" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
