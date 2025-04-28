resource "aws_api_gateway_rest_api" "api" {
  count = var.type == "REST" ? 1 : 0

  name = local.resource_name

  endpoint_configuration {
    types = [var.endpoint_configuration_types]
  }

  binary_media_types = var.binary_media_types

  tags = var.tags
}

resource "aws_apigatewayv2_api" "api" {
  count = var.type != "REST" ? 1 : 0

  name          = local.resource_name
  protocol_type = var.type

  route_selection_expression = var.route_selection_expression != null ? var.route_selection_expression : (var.type == "HTTP" ? "$request.method $request.path" : "$request.body.action")
}

resource "aws_cloudwatch_log_group" "logs" {
  name = "/netex/apigateway/${local.resource_name}"
}

resource "aws_api_gateway_account" "api_account_cloudwatch" {
  count = var.enable_cloudwatch_role ? (var.custom_cloudwatch_role_arn == null) ? 1 : 0 : 0

  cloudwatch_role_arn = aws_iam_role.api_gateway_role.arn
}

resource "aws_api_gateway_account" "api_account_cloudwatch_custom" {
  count = (var.custom_cloudwatch_role_arn != null) ? 1 : 0

  cloudwatch_role_arn = var.custom_cloudwatch_role_arn
}

data "aws_iam_policy_document" "apigw_service_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "api_gateway_role" {
  name               = "${local.resource_name}_apigw"
  assume_role_policy = data.aws_iam_policy_document.apigw_service_assume_role.json
}

resource "aws_iam_role_policy_attachment" "api_gateway_cloudwatch" {
  role       = aws_iam_role.api_gateway_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

# Add SQS inline policy to API Gateway role
data "aws_iam_policy_document" "sqs_policy" {
  statement {
    effect    = "Allow"
    actions   = ["sqs:SendMessage"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "sqs_policy" {
  name   = "sqs_integration"
  role   = aws_iam_role.api_gateway_role.id
  policy = data.aws_iam_policy_document.sqs_policy.json
}
