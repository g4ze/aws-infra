output "aws_instance_web_ids" {
  value = aws_instance.web[*].id
}
output "aws_instance_app_ids" {
  value = aws_instance.app[*].id
}
output "aws_instance_bastion_host_ids" {
  value = aws_instance.bastion_host[*].id
}
output "aws_instance_public_ipv4" {
  value = aws_instance.bastion_host[*].public_ip
}
output "aws_instance_web_private_ips" {
  value = aws_instance.web[*].private_ip
}
output "aws_instance_app_private_ips" {
  value = aws_instance.app[*].private_ip
}
output "private_app_subnet_ips" {
  value = aws_instance.app[*].private_ip
}
output "private_web_subnet_ips" {
  value = aws_instance.web[*].private_ip
}