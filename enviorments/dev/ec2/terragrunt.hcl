terraform {
  source = "tfr:///terraform-aws-modules/ec2-instance/aws?version=3.5.0"
}

include "root"{
	path = find_in_parent_folders()
}
locals {
	config = read_terragrunt_config(find_in_parent_folders("config.hcl"))
	ec2_security_groups = local.config.locals.ec2_security_groups
  ec2_subnets = local.config.locals.ec2_subnet
}

inputs =  {
  instance_type          = "t2.micro"
  ami = "ami-04e5276ebb8451442"
  key_name               = "vtechvibrant.com"
  monitoring             = false
  vpc_security_group_ids =  local.ec2_security_groups
  subnet_id              = local.ec2_subnets
  tags = {
    Name   = "Terragrunt"
  }
}