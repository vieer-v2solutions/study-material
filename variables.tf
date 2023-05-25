
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "image_id" {
  type    = string
  default = "ami-0889a44b331db0194"
}

variable "flavor" {
  type    = string
  default = "t2.micro"
}

variable "ec2_instance_port" {
  type    = number
  default = 80
}


variable "project" {
  type    = string
  default = "Development"
}