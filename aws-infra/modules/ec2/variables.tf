variable "ami_id" {}
variable "key_name" {}
variable "web_subnets" {
  type = list(string)
}
variable "app_subnets" {
  type = list(string)
}
variable "instance_type" {}
variable "security_group_id" {}
