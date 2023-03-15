resource "aws_instance" "Jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.jenkins.id]
  subnet_id = aws_subnet.private[0].id
  tags = {
    Name = "Jenkins"
  }

  user_data = file("Jenkins_install.txt")
}



resource "aws_instance" "ansible" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ansible.id]
  subnet_id = aws_subnet.private[0].id
  tags = {
    Name = "Ansible"
  }

  user_data = file("Ansible installation.txt")
}




