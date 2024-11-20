
# Call VPC module
module "vpc" {
  source          = "./modules/vpc"
  region          = var.region
  cidr_block      = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

# Call NAT Gateway module
module "nat_gateway" {
  source          = "./modules/nat-gateway"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
}
module "security_group" {
  source           = "./modules/security-group"
  vpc_id = module.vpc.vpc_id

}

module "bastion" {
  ami_id = var.ami_id
  security_group_id = module.security_group.security_group_id
  source         = "./modules/bastion"
  public_subnet  = module.vpc.public_subnets[0]
  key_name       = var.key_name

}

module "elb" {
    security_group_id = module.security_group.security_group_id
  source          = "./modules/elb"
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_group  = module.security_group.security_group_id
}

module "ec2" {
  source            = "./modules/ec2"
  web_subnets       = module.vpc.private_web_subnets
  app_subnets       = module.vpc.private_app_subnets
  key_name          = var.key_name
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  security_group_id = module.security_group.security_group_id
}
