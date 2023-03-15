resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "myKey"     
  public_key = tls_private_key.pk.public_key_openssh

}

resource "local_sensitive_file" "pem_file" {
  filename = pathexpand("~/.ssh/${local.ssh_key_name}.pem")
  file_permission = "600"
  directory_permission = "700"
  content = tls_private_key.pk.private_key_pem
}
