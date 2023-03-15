resource "aws_lb" "alb" {
  name               = "public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = [for i in aws_subnet.public : i.id]
}

