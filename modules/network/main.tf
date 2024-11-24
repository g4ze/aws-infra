module "vpc" {
  source = "./vpc"
  cidr_block = var.cidr_block
  vpc_name = var.vpc_name
  public_subnets_cidrs = var.public_subnets_cidrs
  private_app_subnets_cidrs = var.private_app_subnets_cidrs
  private_web_subnets_cidrs = var.private_web_subnets_cidrs
  azs = var.azs
  region = var.region 
}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = module.vpc.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "main-public"
  }
}
resource "aws_route_table_association" "public" {
  count          = length(module.vpc.public_subnet_ids)
  subnet_id      = module.vpc.public_subnet_ids[count.index]
  route_table_id = aws_route_table.main-public.id
}


resource "aws_route_table" "private_app" {
  count  = length(module.vpc.private_app_subnet_ids)
  vpc_id = module.vpc.vpc_id
  
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = module.nat.nat_gateway_id[count.index]
  }

  tags = {
    Name = "${var.vpc_name}-PrivateRT-${count.index + 1}"
  }
}
resource "aws_route_table" "private_web" {
  count  = length(module.vpc.private_web_subnet_ids)
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = module.nat.nat_gateway_id[count.index]
  }

  tags = {
    Name = "${var.vpc_name}-PrivateRT-${count.index + 1}"
  }
}

resource "aws_route_table_association" "private_web" {
  count          = length(module.vpc.private_web_subnet_ids)
  subnet_id      = module.vpc.private_web_subnet_ids[count.index]
  route_table_id = aws_route_table.private_web[count.index].id

}
resource "aws_route_table_association" "private_app" {
  count          = length(module.vpc.private_app_subnet_ids)
  subnet_id      = module.vpc.private_app_subnet_ids[count.index]
  route_table_id = aws_route_table.private_app[count.index].id

}



module "nat" {
  source = "./nat"
  public_subnet_ids = module.vpc.public_subnet_ids
}
resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "prod_igw"
  }
}
resource "aws_network_acl" "assingment1_nacl" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "assingment1_nacl"
  }
}
//security group
resource "aws_security_group" "prod_security_group" {
  vpc_id = module.vpc.vpc_id


  tags = {
    Name = "all in all out sec grp"
  }
}
resource "aws_vpc_security_group_egress_rule" "all_out" {
  security_group_id = aws_security_group.prod_security_group.id

  from_port   = 0
  to_port     = 0
  ip_protocol    = "-1"
  cidr_ipv4 = "0.0.0.0/0"

}
resource "aws_vpc_security_group_ingress_rule" "all_in" {
  security_group_id = aws_security_group.prod_security_group.id

  from_port   = 0
  to_port     = 0
  ip_protocol    = "-1"
  cidr_ipv4 = "0.0.0.0/0"

}