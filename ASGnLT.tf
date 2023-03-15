resource "aws_launch_template" "launch_template" {
  name          = "aws-launch-template"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  network_interfaces {
    device_index    = 0
    security_groups = [aws_security_group.web.id]
  }
  user_data = base64encode(file("apache_install.txt"))

  tags = {
    Name = "asg-web-template"
  }
}



resource "aws_autoscaling_group" "auto_scaling_group" {
  desired_capacity    = 2
  max_size            = 3
  min_size            = 2
  vpc_zone_identifier = [aws_subnet.private[1].id]
  target_group_arns   = [aws_lb_target_group.lb_target_group-2.arn]
  name = "Docker-asg"

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
}

