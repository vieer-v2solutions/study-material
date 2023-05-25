resource "aws_iam_role" "iam_role_ssm" {
  name               = "${var.project}iamrole"
  assume_role_policy = file("./policy/iam_role_trust_policy.json")
}
resource "aws_iam_role_policy" "iam_policy_ssm" {
  name   = "${var.project}iampolicy"
  policy = file("./policy/ssm/ssm_policy.json")
  role   = aws_iam_role.iam_role_ssm.id
}
resource "aws_iam_role_policy" "iam_policy_cloudwatch" {
  name   = "${var.project}iampolicycw"
  policy = file("./policy/cloud_watch/cloud_watch_policy.json")
  role   = aws_iam_role.iam_role_ssm.id
}
resource "aws_iam_instance_profile" "instance_ssm" {
  role = aws_iam_role.iam_role_ssm.id
  name = "${var.project}-Role"
}