output "vpc_id" {
  value = module.vpc.vpc_id
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
output "security_group_id" {
  value = aws_security_group.prod_security_group.id
}
