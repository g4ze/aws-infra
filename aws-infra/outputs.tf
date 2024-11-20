output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "web_instance_ids" {
  value = module.ec2.web_instance_ids
}
