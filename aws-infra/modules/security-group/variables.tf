variable "vpc_id" {}
variable "ingress_port" {
  default = 22
  description = "Port to allow inbound traffic (default: 22 for SSH)"
}
variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "Allowed CIDR blocks for ingress traffic"
  default     = ["0.0.0.0/0"] # Change this to restrict access
}
