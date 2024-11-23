

variable "associate_public_ip_address" {
  type = bool
}
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}
variable "private_web_subnet_ids" {
  type = list(string)
}
variable "private_app_subnet_ids" {
  type = list(string)
}
variable "key_name" {
  type = string
}
variable "security_group_id" {
  type = string
}