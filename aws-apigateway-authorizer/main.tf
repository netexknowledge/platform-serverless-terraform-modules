resource "aws_api_gateway_authorizer" "authorizer" {
  name                             = var.name
  rest_api_id                      = var.api_id
  # authorizer_uri                   = "arn:aws:apigateway:${var.current_region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.current_region}:${var.current_awsaccount_id}:function:${var.parameters.lambda_name}/invocations"
  authorizer_uri                   = var.lambda_function_invoke_arn
  authorizer_credentials           = aws_iam_role.invocation_role.arn
  identity_source                  = try(var.parameters.identity_source, "method.request.header.Authorization")
  authorizer_result_ttl_in_seconds = try(var.parameters.authorizer_result_ttl_in_seconds, 0)
  identity_validation_expression   = "^[0-9]+$"
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

resource "aws_iam_role" "invocation_role" {
  name               = "${var.api_name}_${var.name}_api_gateway_auth_invocation"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.invocation_assume_role.json
}

data "aws_iam_policy_document" "invocation_policy" {
  statement {
    effect  = "Allow"
    actions = ["lambda:InvokeFunction"]
    # resources = [for key, value in var.parameters.authorizers : "arn:aws:lambda:${var.current_region}:${var.current_awsaccount_id}:function:${value.lambda_name}"]
    resources = ["arn:aws:lambda:${var.current_region}:${var.current_awsaccount_id}:function:${var.parameters.lambda_name}"]
  }
}

resource "aws_iam_role_policy" "invocation_policy" {
  name   = "${var.api_name}_${var.name}_api_gateway_invocation_policy"
  role   = aws_iam_role.invocation_role.id
  policy = data.aws_iam_policy_document.invocation_policy.json
}
