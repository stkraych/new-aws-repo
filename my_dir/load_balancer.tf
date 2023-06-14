resource "aws_lb" "load_balancer" {
  name               = "load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  enable_deletion_protection = false
  tags = {
    name = "load-balancer"
  }
}


resource "aws_lb_target_group" "alb_target" {
  name     = "alb-targets"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.autoscalling_vpc.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  tags = {
    name = "lb-listener"
  }
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target.arn
  }
}
