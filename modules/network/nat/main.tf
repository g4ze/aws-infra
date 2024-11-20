resource "aws_eip" "nat" {
  count = length(var.public_subnet_ids)
  domain = "vpc"
  tags = {
    Name = "NAT Gateway EIP-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = length(var.public_subnet_ids)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = var.public_subnet_ids[count.index]
  
  tags = {
    Name = "NatGateway-${count.index + 1}"
  }
  depends_on = [aws_eip.nat]
}
