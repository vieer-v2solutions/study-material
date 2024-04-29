terraform {
  source = "tfr:///terraform-aws-modules/autoscaling/aws?version=7.4.1"
}
include "root"{
	path = find_in_parent_folders()
}
locals {
  config = yamldecode(file("${find_in_parent_folders("config.yaml")}"))
}
dependency "loadbalancer" {
  config_path = "../loadbalancer"
  mock_outputs = {
    target_groups = []
  }
}
inputs =  {
  name = local.config.auto_scaling.name
  target_group_arns = [for tg_key, tg_val in dependency.loadbalancer.outputs.target_groups : tg_val["arn"]]
  min_size                  = local.config.auto_scaling.min_size
  max_size                  = local.config.auto_scaling.max_size
  desired_capacity          = local.config.auto_scaling.desired_capacity
  wait_for_capacity_timeout = local.config.auto_scaling.wait_for_capacity_timeout
  health_check_type         = local.config.auto_scaling.health_check_type
  vpc_zone_identifier       = local.config.subnets
  initial_lifecycle_hooks = local.config.auto_scaling.initial_lifecycle_hooks
  instance_refresh = local.config.auto_scaling.instance_refresh
  launch_template_name        = local.config.auto_scaling.launch_template.name
  launch_template_description = local.config.auto_scaling.launch_template.launch_template_description
  update_default_version      = local.config.auto_scaling.launch_template.update_default_version
  image_id          = local.config.auto_scaling.launch_template.image_id
  instance_type     = local.config.auto_scaling.launch_template.instance_type
  ebs_optimized     = local.config.auto_scaling.launch_template.ebs_optimized
  enable_monitoring = local.config.auto_scaling.launch_template.enable_monitoring
  create_iam_instance_profile = false
  iam_instance_profile_arn = local.config.auto_scaling.launch_template.iam_instance_profile_arn
  block_device_mappings = local.config.auto_scaling.launch_template.block_device_mappings
  capacity_reservation_specification = local.config.auto_scaling.launch_template.capacity_reservation_specification
  cpu_options = local.config.auto_scaling.launch_template.cpu_options
  credit_specification = local.config.auto_scaling.launch_template.credit_specification
  instance_market_options = local.config.auto_scaling.launch_template.instance_market_options
  metadata_options = local.config.auto_scaling.launch_template.metadata_options
  network_interfaces = local.config.auto_scaling.launch_template.network_interfaces
  placement = local.config.auto_scaling.launch_template.placement
  tag_specifications = [
    {
      resource_type = "instance"
      tags          = { 
        Environment = local.config.Enviorment
        Project     = local.config.Project
        }
    },
    {
      resource_type = "volume"
      tags          = { 
          Environment = local.config.Enviorment
          Project     = local.config.Project
        }
    },
    {
      resource_type = "spot-instances-request"
      tags          = { 
        Environment = local.config.Enviorment
        Project     = local.config.Project
      }
    }
  ]

  tags = {
    Environment = local.config.Enviorment
    Project     = local.config.Project
  }
}