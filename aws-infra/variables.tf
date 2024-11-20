variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "key_name" {
  description = "Name of the EC2 key pair"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  default = "ami-04a37924ffe27da53"

}

variable "instance_type" {
  default = "t2.micro"
}
