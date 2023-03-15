resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id 
  }
  
  tags = {
    Name = "public_rt"
  }
}



resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example.id
  }

  tags = {
    Name = "private_rt"
  }
}

