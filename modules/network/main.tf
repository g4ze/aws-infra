module "vpc" {
  source = "./vpc"
  cidr_block = var.cidr_block
  vpc_name = var.vpc_name
  public_subnets_cidrs = var.public_subnets_cidrs
  private_app_subnets_cidrs = var.private_app_subnets_cidrs
  private_web_subnets_cidrs = var.private_web_subnets_cidrs
  azs = var.azs
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