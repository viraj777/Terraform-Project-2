resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.test.id
  cidr_block = local.public_subnets[count.index]
  count = 2
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch =  true 

  tags = {
    Name = "public${count.index}"
  }
}


resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.test.id
  cidr_block = local.private_subnets[count.index]
  count = 2
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "private${count.index}"
  }
}
