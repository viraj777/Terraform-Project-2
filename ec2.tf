
resource "aws_instance" "Jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.jenkins.id]
  subnet_id = aws_subnet.private[0].id
  key_name = aws_key_pair.kp.key_name
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
  key_name = aws_key_pair.kp.key_name
  tags = {
    Name = "Ansible"
  }

  user_data = file("Ansible installation.txt")
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.bastian.id]
  subnet_id = aws_subnet.public[0].id
  key_name = aws_key_pair.kp.key_name
  tags = {
    Name = "Bastian-EC2"
  }

}




























