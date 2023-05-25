terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA5AFK32U7VGXSC74A"
  secret_key = "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"
}
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
data "aws_vpc" "default" {
  default = true
}
terraform {
  backend "s3" {
    bucket = "terraform-backend-vieer"
    key    = "Terraform/backend"
    region = "us-east-1"
    access_key = "AKIA5AFK32U7VGXSC74A"
    secret_key = "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"
  }
}