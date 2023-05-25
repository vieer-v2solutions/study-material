resource "aws_security_group" "alb-sec-group" {
  name        = var.project
  description = "Security Group for the ELB (ALB)"
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "asg_sec_group" {
  name        = "${var.project}-asg"
  description = "Security Group for the ASG"
  tags = {
    name = "name"
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 80
    protocol        = "tcp"
    to_port         = 80
    security_groups = [aws_security_group.alb-sec-group.id]
  }
}
