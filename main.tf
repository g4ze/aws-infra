module "network" {
  source                    = "./modules/network"
  cidr_block                = var.cidr_block
  private_web_subnets_cidrs = var.private_web_subnets_cidrs
  private_app_subnets_cidrs = var.private_app_subnets_cidrs
  public_subnets_cidrs      = var.public_subnets_cidrs
  vpc_name                  = "vpc-1"
  azs                       = var.azs
  region                    = var.region1
}
module "server" {
  source                      = "./modules/server"
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_group_id           = module.network.security_group_id
  private_web_subnet_ids      = module.network.private_web_subnet_ids
  private_app_subnet_ids      = module.network.private_app_subnet_ids
  public_subnet_ids           = module.network.public_subnet_ids
  associate_public_ip_address = false
}
module "elb" {
  source               = "./modules/elb"
  aws_instance_web_ids = module.server.aws_instance_web_ids
  public_subnet_ids    = module.network.public_subnet_ids
  security_group_id    = module.network.security_group_id
  vpc_id               = module.network.vpc_id
  tg_name              = "tg-1"
}

/////////////////////////////

module "network2" {
  source                    = "./modules/network"
  providers = {
    aws = aws.us-east-2
  }
  cidr_block                = var.cidr_block2
  private_web_subnets_cidrs = var.private_web_subnets_cidrs2
  private_app_subnets_cidrs = var.private_app_subnets_cidrs2
  public_subnets_cidrs      = var.public_subnets_cidrs2
  vpc_name                  = "vpc-2"
  azs                       = var.azs2
  region                    = var.region2
}
# vpc-037dbb57cd2f04b11
module "server2" {
  providers = {
    aws = aws.us-east-2
  }
  source                      = "./modules/server"
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_group_id           = module.network2.security_group_id
  private_web_subnet_ids      = module.network2.private_web_subnet_ids
  private_app_subnet_ids      = module.network2.private_app_subnet_ids
  public_subnet_ids           = module.network2.public_subnet_ids
  associate_public_ip_address = false
}
module "elb2" {
  source               = "./modules/elb"
  providers = {
    aws = aws.us-east-2
  }
  aws_instance_web_ids = module.server2.aws_instance_web_ids
  public_subnet_ids    = module.network2.public_subnet_ids
  security_group_id    = module.network2.security_group_id
  vpc_id               = module.network2.vpc_id
  tg_name              = "tg-2"
}
///////////////////////////////////////



// we wont make a zone as we need it to be alr made since we are using thrid part domain
resource "aws_route53_record" "region1_route53_record" {
  type           = "A"
  zone_id        = "Z05900013PGBKBFT1VA59" //aws_route53_zone.main.id // being jardcoded sice we are using 3rd party domain
  name           = "nilay.tech"
  set_identifier = "region1"

  alias {
    name                   = module.elb.lb_dns_name
    zone_id                = module.lb.lb_zone_id
    evaluate_target_health = true
  }

  weighted_routing_policy {
    weight = 50
  }
}

resource "aws_route53_record" "region2_route53_record" {
  type           = "A"
  zone_id        = "Z05900013PGBKBFT1VA59"
  name           = "nilay.tech"
  set_identifier = "region2"

  alias {
    name                   = module.elb2.lb_dns_name
    zone_id                = module.elb2.lb_zone_id
    evaluate_target_health = true
  }

  weighted_routing_policy {
    weight = 50
  }
}