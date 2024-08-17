provider "aws" {
  region = "us-east-1"
}

module "jenkins" {
  source = "../../modules/jenkins"

  ami_id         = "ami-0ae8f15ae66fe8cda"
  instance_type  = "t2.micro"
  vpc_id        = "vpc-00b7b978df7cb4db6"
}

