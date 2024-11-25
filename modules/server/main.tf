resource "aws_instance" "web" {
  count           = length(var.private_web_subnet_ids)
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.private_web_subnet_ids[count.index]
  key_name        = var.key_name
  security_groups = [var.security_group_id]
  user_data       = file("${path.module}/web.sh")
  tags = {
    Name = "WebServer-${count.index}"
  }
}

resource "aws_instance" "app" {
  count           = length(var.private_app_subnet_ids)
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.private_app_subnet_ids[count.index]
  key_name        = var.key_name
  security_groups = [var.security_group_id]

  tags = {
    Name = "AppServer-${count.index}"
  }
}

resource "aws_instance" "bastion_host" {
  count           = length(var.public_subnet_ids)
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.public_subnet_ids[count.index]
  key_name        = var.key_name
  user_data       = file("${path.module}/bastion.sh")
  security_groups = [var.security_group_id]
  tags = {
    Name = "BastionHost-${count.index}"
  }
}