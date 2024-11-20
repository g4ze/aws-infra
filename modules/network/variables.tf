variable "cidr_block"{
    type = string
  }
variable "vpc_name" {
  type = string
}
variable "public_subnets_cidrs" {
  type = list(string)
}
variable "private_web_subnets_cidrs" {
  type = list(string)
}
variable "private_app_subnets_cidrs" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}