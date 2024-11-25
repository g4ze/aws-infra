
provider "aws" {
  alias = "us-east-2"

  region = "us-east-2"
}

provider "aws" {
  region = "ap-south-1"
}
# not reqiuired