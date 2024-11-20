output "vpc_id" {
  value = module.vpc.vpc_id //string
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids //list of string
}

output "private_web_subnet_ids" {
  value = module.vpc.private_web_subnet_ids //list of string
}
output "private_app_subnet_ids" {
  value = module.vpc.private_app_subnet_ids //list of string
}
