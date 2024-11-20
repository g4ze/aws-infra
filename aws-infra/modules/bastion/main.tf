resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = var.public_subnet
  security_groups = [var.security_group_id] # Attach security group

  tags = {
    Name = "BastionHost"
  }
}
