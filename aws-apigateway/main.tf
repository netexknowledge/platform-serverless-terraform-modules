resource "aws_api_gateway_rest_api" "api" {
  name = var.name
}

resource "aws_cloudwatch_log_group" "logs" {
  name = "/netex/apigateway/${var.name}"
}
