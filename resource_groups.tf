resource "aws_resourcegroups_group" "database_grp" {
  name = "database-${var.project}"
  resource_query {
    query = <<JSON
    {
    "ResourceTypeFilters": [
      "AWS::EC2::Instance"
    ],
    "TagFilters": [
      {
        "Key": "Environment",
        "Values": ["${var.project}"]
      },
      {
        "Key": "Resource_type",
        "Values": ["Database"]
      }
    ]
  }
  JSON
  }
}
resource "aws_resourcegroups_group" "application_grp" {
  name = "application-${var.project}"
  resource_query {
    query = <<JSON
    {
    "ResourceTypeFilters": [
      "AWS::EC2::Instance"
    ],
    "TagFilters": [
      {
        "Key": "Environment",
        "Values": ["${var.project}"]
      },
      {
        "Key": "Resource_type",
        "Values": ["Application"]
      }
    ]
  }
  JSON
  }
}
# resource "aws_resourcegroups_group" "webserver_grp" {
#   name = "webservers-${var.project}"
#   resource_query {
#     query = <<JSON
#     {
#     "ResourceTypeFilters": [
#       "AWS::EC2::Instance"
#     ],
#     "TagFilters": [
#       {
#         "Key": "Environment",
#         "Values": ["${var.project}"]
#       },
#       {
#         "Key": "Resource_type",
#         "Values": ["Webserver"]
#       }
#     ]
#   }
#   JSON
#   }
# }
