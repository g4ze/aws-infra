output "vpc_id" {
  value = aws_vpc.prod_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_app_subnet_ids" {
  value = aws_subnet.private1[*].id
}
output "private_web_subnet_ids" {
  value = aws_subnet.private2[*].id
}
