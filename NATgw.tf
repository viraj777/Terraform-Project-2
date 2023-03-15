resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.nat_gw.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "nat_gw" {
  vpc      = true
}
