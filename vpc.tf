terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
data "aws_vpc" "default" {
  default = true
}
terraform {
  backend "s3" {
    bucket = ""
    key    = ""
    region = ""
  }
}