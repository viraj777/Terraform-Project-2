resource "aws_lb_target_group" "lb_target_group-1" {
  name     = "lb-target-group-1"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.test.id
}

resource "aws_lb_target_group" "lb_target_group-2" {
  name     = "lb-target-group-2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.test.id
}

resource "aws_lb_listener" "Jenkins_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group-1.arn
  }
}

resource "aws_lb_listener" "Nginx_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "85"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group-2.arn
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.lb_target_group-1.arn
  target_id        = aws_instance.Jenkins.id
  port             = 8080
}
