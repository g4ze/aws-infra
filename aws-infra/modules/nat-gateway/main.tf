resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  count = length(var.public_subnet_ids)
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnets[0]
  tags = {
    Name = "NatGateway"
  }
}
