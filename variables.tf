
variable "cidr_block" {
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
variable "azs2" {
  type = list(string)
}
variable "ami" {
  type    = string
  default = "ami-04a37924ffe27da53"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "key_name" {
  type    = string
  default = "test"
}
variable "region1" {

}
variable "region2" {

}
variable "cidr_block2" {

}
variable "private_web_subnets_cidrs2" {

}
variable "private_app_subnets_cidrs2" {

}
variable "public_subnets_cidrs2" {

}
