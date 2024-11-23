resource "aws_lb" "lb" {
  load_balancer_type = "application"
  enable_cross_zone_load_balancing = true
  subnets = var.public_subnet_ids
  internal = false
  
  security_groups = [ var.security_group_id ]
  tags = {
    Name = "web-elb"
  }
}
resource "aws_lb_target_group" "target_elb" {
  name     = var.tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path     = "/health"
    port     = 80
    protocol = "HTTP"
  }
}
resource "aws_lb_target_group_attachment" "tg_attachment" {
  count = length(var.aws_instance_web_ids)
  target_group_arn = aws_lb_target_group.target_elb.arn
  target_id        = var.aws_instance_web_ids[count.index]
  port             = 80
  depends_on = [
    aws_lb_target_group.target_elb,
  ]
}