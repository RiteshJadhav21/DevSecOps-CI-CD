terraform {
  backend "s3" {
    bucket = "my-dev-terraform-state-bucket-001"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}
