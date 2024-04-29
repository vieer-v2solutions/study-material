terraform {
  source = "tfr:///terraform-aws-modules/alb/aws?version=9.9.0"
}
include "root"{
	path = find_in_parent_folders()
}
locals {
  config = yamldecode(file("${find_in_parent_folders("config.yaml")}"))
}
inputs =  {
  name = local.config.load_balancer.name
  create_security_group = false
  enable_deletion_protection = false
  vpc_id = local.config.vpc_id
  security_groups = local.config.load_balancer.security_groups
  subnets = local.config.subnets
  target_groups = local.config.load_balancer.target_groups
  listeners = local.config.load_balancer.listeners
  tags = {
    Enviorment = local.config.Enviorment
  }
}