terraform {
  backend "s3" {
    bucket         = "qamar-terraform-s3"
    key            = "3tier/dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}