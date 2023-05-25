resource "aws_launch_configuration" "ec2_template" {
  image_id        = var.image_id
  instance_type   = var.flavor
  user_data       = file("./userdata.sh")
  security_groups = [aws_security_group.asg_sec_group.id]
  lifecycle {
    create_before_destroy = true
  }
  iam_instance_profile = aws_iam_instance_profile.instance_ssm.id
}