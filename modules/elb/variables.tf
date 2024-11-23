variable "public_subnet_ids"{
    type = list(string)
}
variable "security_group_id" {
    type = string 
}
variable "vpc_id" {
    type = string 
}
variable "aws_instance_web_ids" {
    type = list(string)
}
variable "tg_name" {
  
}