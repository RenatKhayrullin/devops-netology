terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"

  backend "s3" {
    bucket = "terraform-states"
    encrypt = true
    key = "main-infra/terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "terraform-locks"
  }
}