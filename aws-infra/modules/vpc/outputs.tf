output "vpc_id" {
  value = aws_vpc.prod_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_web_subnets_ids" {
  value = aws_subnet.private[*].id
}
