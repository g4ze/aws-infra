resource "aws_instance" "web" {
  count         = length(var.web_subnets)
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.web_subnets[count.index]
  key_name      = var.key_name
  security_groups = [var.security_group_id] # Attach security group

  tags = {
    Name = "WebServer-${count.index}"
  }
}

resource "aws_instance" "app" {
  count         = length(var.app_subnets)
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.app_subnets[count.index]
  key_name      = var.key_name
  security_groups = [var.security_group_id] # Attach security group

  tags = {
    Name = "AppServer-${count.index}"
  }
}
