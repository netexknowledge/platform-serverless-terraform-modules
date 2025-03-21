data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "datadog_apikey" {
  count = var.add_datadog_layer ? 1 : 0

  name = "/secrets/k8s/common/${var.tags["environment"]}/datadog/apikey"
}

locals {
  product_name              = format("%s", var.tags["product"])
  product_path              = format("%s", var.tags["product"])
  product_name_multiregion  = format("%s-%s", var.tags["product"], var.tags["environment"])
  product_path_multiregion  = format("%s/%s", var.tags["product"], var.tags["environment"])
  resource_name             = format("%s-%s-%s", var.tags["product"], var.tags["project"], var.parameters.function_name)
  resource_path             = format("%s/%s/%s", var.tags["product"], var.tags["project"], var.parameters.function_name)
  resource_name_multiregion = format("%s-%s-%s-%s", var.tags["product"], var.tags["environment"], var.tags["project"], var.parameters.function_name)
  resource_path_multiregion = format("%s/%s/%s/%s", var.tags["product"], var.tags["environment"], var.tags["project"], var.parameters.function_name)

  aws_account_id = data.aws_caller_identity.current.account_id
}
