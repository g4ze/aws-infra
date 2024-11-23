terraform {
  backend "s3" {
    bucket = "be-s3-bu"
    region = "ap-south-1"
    key = "terraform.tfstate"
  }
}