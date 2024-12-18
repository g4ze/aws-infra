output "bastion_host_public_ip" {
  value = module.server.aws_instance_public_ipv4 // list
}
output "aws_instance_web_private_ips" {
  value = module.server.aws_instance_web_private_ips
}
output "aws_instance_app_private_ips" {
  value = module.server.aws_instance_app_private_ips
}

output "vpc1_id" {
  value = module.network.vpc_id
}

output "vpc2_id" {
  value = module.network2.vpc_id
}