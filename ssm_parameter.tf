resource "aws_ssm_parameter" "cw_parameter" {
  type  = "String"
  name  = "cwParameter"
  value = file("./policy/ssm/parameter.json")
}