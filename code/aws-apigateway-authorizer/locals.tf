# Retrieve the current AWS region
data "aws_region" "current" {}

# Retrieve the AWS account ID
data "aws_caller_identity" "current" {}

locals {
  product_name              = format("%s", var.tags["product"])
  product_path              = format("%s", var.tags["product"])
  product_name_multiregion  = format("%s-%s", var.tags["product"], var.tags["environment"])
  product_path_multiregion  = format("%s/%s", var.tags["product"], var.tags["environment"])
  resource_name             = format("%s-%s-%s", var.tags["product"], var.tags["project"], var.name)
  resource_path             = format("%s/%s/%s", var.tags["product"], var.tags["project"], var.name)
  resource_name_multiregion = format("%s-%s-%s-%s", var.tags["product"], var.tags["environment"], var.tags["project"], var.name)
  resource_path_multiregion = format("%s/%s/%s/%s", var.tags["product"], var.tags["environment"], var.tags["project"], var.name)

  lambda_authorizer_arn = format("arn:aws:lambda:%s:%s:function:%s", data.aws_region.current.name, data.aws_caller_identity.current.account_id,
    lookup(var.parameters, "lambda_authorizer_name", "cloud-authorizer-authorizer")
  )
  lambda_authorizer_invoke_arn = format(
    "arn:aws:apigateway:%s:lambda:path/2015-03-31/functions/%s/invocations",
    data.aws_region.current.name,
    local.lambda_authorizer_arn
  )
}
