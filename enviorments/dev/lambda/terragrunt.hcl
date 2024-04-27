terraform {
  source = "tfr:///terraform-aws-modules/lambda/aws?version=7.2.6"
}
include "root"{
	path = find_in_parent_folders()
}

inputs =  {
  function_name = "Terragrunt"
  description   = "My awesome lambda function"
  handler       = "main.main"
  runtime       = "python3.10"
  create_package         = false
  package_type = "Zip"
  local_existing_package = "main.zip"
}