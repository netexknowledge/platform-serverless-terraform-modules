resource "aws_api_gateway_rest_api" "api" {
  name = var.name

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "logs" {
  name = "/netex/apigateway/${var.name}"
}

resource "aws_api_gateway_account" "api_account_cloudwatch" {
  count = var.enable_cloudwatch_role ? (var.custom_cloudwatch_role_arn == null) ? 1 : 0 : 0

  cloudwatch_role_arn = aws_iam_role.api_account_cloudwatch[0].arn
}

resource "aws_api_gateway_account" "api_account_cloudwatch_custom" {
  count = (var.custom_cloudwatch_role_arn != null) ? 1 : 0

  cloudwatch_role_arn = var.custom_cloudwatch_role_arn
}

data "aws_iam_policy_document" "api_account_cloudwatch_assume_role" {
  count = var.enable_cloudwatch_role ? 1 : 0

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "api_account_cloudwatch" {
  count = var.enable_cloudwatch_role ? 1 : 0

  name               = "api_gateway_cloudwatch_global"
  assume_role_policy = data.aws_iam_policy_document.api_account_cloudwatch_assume_role[0].json
}

data "aws_iam_policy_document" "api_account_cloudwatch" {
  count = var.enable_cloudwatch_role ? 1 : 0

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "api_account_cloudwatch" {
  count = var.enable_cloudwatch_role ? 1 : 0

  name   = "apiAccountCloudwatchPolicy"
  role   = aws_iam_role.api_account_cloudwatch[0].id
  policy = data.aws_iam_policy_document.api_account_cloudwatch[0].json
}
