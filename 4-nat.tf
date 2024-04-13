resource "aws_nat_gateway" "nat" {
  subnet_id = aws_subnet.public_us_east_2a.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}