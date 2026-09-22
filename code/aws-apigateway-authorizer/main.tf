resource "aws_api_gateway_authorizer" "authorizer" {
  count = var.type == "REST" ? 1 : 0

  name                             = local.resource_name
  rest_api_id                      = var.api_id
  authorizer_uri                   = var.lambda_function_invoke_arn != null ? var.lambda_function_invoke_arn : local.lambda_authorizer_invoke_arn
  authorizer_credentials           = aws_iam_role.invocation_role.arn
  identity_source                  = lookup(var.parameters, "identity_source", "method.request.header.Authorization")
  authorizer_result_ttl_in_seconds = lookup(var.parameters, "authorizer_result_ttl_in_seconds", 0)
  identity_validation_expression   = lookup(var.parameters, "identity_validation_expression", "^[0-9]+$")
}

resource "aws_apigatewayv2_authorizer" "authorizer" {
  count = var.type == "REST" ? 0 : 1

  name                              = local.resource_name
  api_id                            = var.api_id
  authorizer_type                   = "REQUEST"
  authorizer_uri                    = var.lambda_function_invoke_arn != null ? var.lambda_function_invoke_arn : local.lambda_authorizer_invoke_arn
  identity_sources                  = var.type == "WEBSOCKET" ? [lookup(var.parameters, "identity_source", "route.request.header.Authorization")] : [lookup(var.parameters, "identity_source", "$request.header.Authorization")]
  authorizer_result_ttl_in_seconds  = var.type == "WEBSOCKET" ? null : lookup(var.parameters, "authorizer_result_ttl_in_seconds", 0)
  authorizer_payload_format_version = var.type == "WEBSOCKET" ? null : lookup(var.parameters, "authorizer_payload_format_version", "1.0")
}

data "aws_iam_policy_document" "invocation_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "random_string" "role_suffix" {
  length  = 6
  special = false
  lower   = true
  upper   = false
  numeric = true
}

resource "aws_iam_role" "invocation_role" {
  name               = "${local.resource_name}_${random_string.role_suffix.result}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.invocation_assume_role.json

  tags = var.tags
}

data "aws_iam_policy_document" "invocation_policy" {
  statement {
    effect    = "Allow"
    actions   = ["lambda:InvokeFunction"]
    resources = [var.lambda_function_arn != null ? var.lambda_function_arn : local.lambda_authorizer_arn]
  }
}

resource "aws_iam_role_policy" "invocation_policy" {
  name   = "lambda_invocation"
  role   = aws_iam_role.invocation_role.id
  policy = data.aws_iam_policy_document.invocation_policy.json
}
