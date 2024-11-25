cidr_block                = "15.0.0.0/16"
private_app_subnets_cidrs = ["15.0.0.0/20", "15.0.16.0/20"]
public_subnets_cidrs      = ["15.0.128.0/20", "15.0.144.0/20"]
private_web_subnets_cidrs = ["15.0.160.0/20", "15.0.176.0/20"]
azs                       = ["ap-south-1a", "ap-south-1b"]
azs2                      = ["us-east-2a", "us-east-2b"]
ami                       = "ami-04a37924ffe27da53"
instance_type             = "t2.micro"
# public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGKWfaAfJBWGngYYL/nv709V8Fu5ApLjdtrzWkUot4PHAcbORaJ4YohM8LtsmcZGrdgC6r1V7h1bElyu30f5QpCOqTT+UT7nD4nrVYGlEuR4CCz9+0ckc84QkeAjkukcsPKGPzClxPbsFJaCuCBDNYs/B4dIRamzgmgg3mvBGizYQROGfT1mNrrstGrUHBBMh2vaLWTash+JP6VMEq8WqyaWKI2tUEmRMG8wuH43x5lRybmYnl1RgGzIq9MBZdSXZE/dhto2f2BJiKin4tDMez97xKLIlcLCKa2EVi/Lluzw19pToaV43GIwtarTvCrrRNw+40vBUD8U9LX7QIZWBtOejq+jaVLwVVLKJXpy9jfVZyNDKfDnOL9rfFpYmdvkKfdXTOptqNVMDnX5pUkmbRgy4k26rjg1UFsX+JKw0C5wcyq65nQwYGsxbAqI88nzQxsxQz0iMqhWXkeXKN9XLSqeaAbRZwyf6R9hUFBGPijVW2yrokg1IDGdeb9Ctke2k= nilay@daddysprincess"
key_name                   = "test"
region1                    = "ap-south-1"
region2                    = "us-east-2"
cidr_block2                = "16.0.0.0/16"
private_web_subnets_cidrs2 = ["16.0.0.0/20", "16.0.16.0/20"]
private_app_subnets_cidrs2 = ["16.0.160.0/20", "16.0.176.0/20"]
public_subnets_cidrs2      = ["16.0.128.0/20", "16.0.144.0/20"]