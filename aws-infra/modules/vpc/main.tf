resource "aws_vpc" "prod_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.vpc_name
  }
}
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets_cidrs)
  vpc_id                  = aws_vpc.prod_vpc.id
  cidr_block              = var.public_subnets_cidrs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = format(var.vpc_name," PublicSubnet-${count.index + 1}")
  }
}
resource "aws_subnet" "private" {
  count      = length(var.private_subnets_cidrs)
  vpc_id     = aws_vpc.prod_vpc.id
  cidr_block = var.private_subnets_cidrs[count.index]
  tags = {
    Name = format(var.vpc_name, " PrivateSubnet-${count.index + 1}")
  }
}
