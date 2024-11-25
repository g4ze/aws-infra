
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
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = format("%s %s", var.vpc_name, " PublicSubnet-${count.index + 1}")
  }
}
resource "aws_subnet" "private1" {
  count             = length(var.private_web_subnets_cidrs)
  vpc_id            = aws_vpc.prod_vpc.id
  availability_zone = var.azs[count.index]
  cidr_block        = var.private_web_subnets_cidrs[count.index]
  tags = {
    Name = format("%s %s", var.vpc_name, " PrivateSubnet1-${count.index + 1}")
  }
}
resource "aws_subnet" "private2" {
  count             = length(var.private_app_subnets_cidrs)
  vpc_id            = aws_vpc.prod_vpc.id
  availability_zone = var.azs[count.index]
  cidr_block        = var.private_app_subnets_cidrs[count.index]
  tags = {
    Name = format("%s %s", var.vpc_name, " PrivateSubnet2-${count.index + 1}")
  }
}
