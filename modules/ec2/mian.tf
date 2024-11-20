resource "aws_instance" "prod_server" {
  subnet_id                   = var.vpc_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = var.associate_public_ip_address
  ami                         = var.ami
  instance_type               = var.instance_type
  tags = {
    Name = var.name
  }
}
resource "aws_instance" "web" {
  count         = length(var.private_web_subnet_ids)
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.private_web_subnet_ids[count.index]
  key_name      = var.key_name
  security_groups = [var.security_group_id]

  tags = {
    Name = "WebServer-${count.index}"
  }
}

resource "aws_instance" "app" {
  count         = length(var.private_app_subnet_ids)
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.private_app_subnet_ids[count.index]
  key_name      = var.key_name
  security_groups = [var.security_group_id] 

  tags = {
    Name = "AppServer-${count.index}"
  }
}
