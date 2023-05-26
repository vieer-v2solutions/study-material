resource "aws_autoscaling_group" "Practice_ASG" {
  max_size                  = 10
  min_size                  = 2
  desired_capacity          = 3
  launch_configuration      = aws_launch_configuration.ec2_template.name
  health_check_grace_period = 300
  health_check_type         = "ELB"
  vpc_zone_identifier       = data.aws_subnet_ids.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "${var.project}-Application"
  }
  tag {
    key                 = "Environment"
    propagate_at_launch = true
    value               = var.project
  }
  tag {
    key                 = "Resource_type"
    propagate_at_launch = true
    value               = "Application"
  }
  lifecycle {
    create_before_destroy = true
  }
}