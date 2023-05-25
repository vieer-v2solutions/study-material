# resource "aws_ssm_document" "database" {
#   name            = "${var.project}-database"
#   document_format = "YAML"
#   document_type   = "Command"
#   target_type     = "/AWS::EC2::Instance"
#   content         = file("./documents/database.yaml")
# }

resource "aws_ssm_document" "application" {
  name            = "${var.project}-application"
  document_format = "YAML"
  document_type   = "Command"
  target_type     = "/AWS::EC2::Instance"
  content         = file("./documents/application.yaml")
}