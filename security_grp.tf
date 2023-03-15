resource "aws_security_group" "alb_security_group" {
  name        = "alb-security-group"
  description = "ALB Security Group"
  vpc_id      = aws_vpc.test.id

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from Internet"
    from_port   = 85
    to_port     = 85
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "jenkins" {
  name        = "jenkins-security-group"
  description = "jenkins Security Group"
  vpc_id      = aws_vpc.test.id

  ingress {
    description = "HTTP from Internet"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  ingress {
    description = "SSH only  from bastian EC2 "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastian.id]
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "ansible" {
  name        = "ansible-security-group"
  description = "Ansible Security Group"
  vpc_id      = aws_vpc.test.id

  ingress {
    description = "SSH only from jenkins and bastian EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.jenkins.id, aws_security_group.bastian.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "web" {
  name        = "web-security-group"
  description = "Web Security Group"
  vpc_id      = aws_vpc.test.id

  ingress {
    description = "SSH only from ansible controller and bastian EC2 "
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.ansible.id, aws_security_group.bastian.id]
  }

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
#    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "bastian" {
  name        = "bastian-security-group"
  description = "bastian Security Group"
  vpc_id      = aws_vpc.test.id

  ingress {
    description = "SSH from Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
