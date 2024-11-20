variable "region" {}
variable "cidr_block" {
 default = "15.0.0.0/16"
}
variable "public_subnets_cidrs" {
  type = list(string)
}
variable "private_subnets_cidrs" {
  type = list(string)
}
variable "vpc_name" {
  default = "prod_vpc"
}
