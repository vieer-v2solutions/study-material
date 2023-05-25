resource "aws_ssm_association" "application" {
  name            = aws_ssm_document.application.name
  max_errors      = 1
  max_concurrency = 2
  targets {
    key    = "resource-groups:Name"
    values = ["${aws_resourcegroups_group.application_grp.name}"]
  }
}

# resource "aws_ssm_association" "webserver" {
#   name            = aws_ssm_document.webserver.name
#   max_errors      = 1
#   max_concurrency = 2
#   targets {
#     key    = "resource-groups:Name"
#     values = ["${aws_resourcegroups_group.webserver_grp.name}"]
#   }
# }
# resource "aws_ssm_association" "database" {
#   name            = aws_ssm_document.database.name
#   max_errors      = 1
#   max_concurrency = 2
#   targets {
#     key    = "resource-groups:Name"
#     values = ["${aws_resourcegroups_group.database_grp.name}"]
#   }
# }