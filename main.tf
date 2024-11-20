module "network" {
  source = "./modules/network"
  cidr_block = var.cidr_block
  private_web_subnets_cidrs = var.private_web_subnets_cidrs
  private_app_subnets_cidrs = var.private_app_subnets_cidrs
  public_subnets_cidrs = var.public_subnets_cidrs
  vpc_name = var.vpc_name
  azs = var.azs
}
module "ec2" {
  source = "./modules/ec2"
  ami = var.ami
  associate_public_ip_address = 
}