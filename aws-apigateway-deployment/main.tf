resource "aws_api_gateway_deployment" "deployment" {
  count = var.type == "REST" ? 1 : 0

  rest_api_id = var.api_id
  triggers = {
    "redeployment" = lookup(var.triggers, "redeployment", sha1(formatdate("EEEE, DD-MMM-YY hh:mm:ss ZZZ", timestamp())))
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  count = var.type == "REST" ? 1 : 0

  deployment_id = aws_api_gateway_deployment.deployment[0].id
  rest_api_id   = var.api_id
  stage_name    = var.stage_name == "$default" ? "default" : var.stage_name

  dynamic "access_log_settings" {
    for_each = var.enable_cloudwatch_role ? [1] : []

    content {
      destination_arn = var.cloudwatch_log_group_arn
      format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "routeKey" : "$context.routeKey", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength", "integrationError" : "$context.integrationErrorMessage" })
    }
  }

  tags = var.tags
}

resource "aws_apigatewayv2_deployment" "deployment" {
  count = var.type == "REST" ? 0 : 1

  api_id = var.api_id
  triggers = {
    "redeployment" = lookup(var.triggers, "redeployment", sha1(formatdate("EEEE, DD-MMM-YY hh:mm:ss ZZZ", timestamp())))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_apigatewayv2_stage" "stage" {
  count = var.type == "REST" ? 0 : 1

  api_id        = var.api_id
  deployment_id = aws_apigatewayv2_deployment.deployment[0].id
  name          = var.stage_name != "$default" ? var.stage_name : (var.type == "HTTP" ? "$default" : "default")

  dynamic "access_log_settings" {
    for_each = var.enable_cloudwatch_role ? [1] : []

    content {
      destination_arn = var.cloudwatch_log_group_arn
      format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "routeKey" : "$context.routeKey", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength", "integrationError" : "$context.integrationErrorMessage" })
    }
  }

  tags = var.tags
}
