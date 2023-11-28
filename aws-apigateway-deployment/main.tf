resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = var.api_id
  triggers    = var.triggers
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = var.api_id
  stage_name    = var.stage_name
  # access_log_settings {
  #   destination_arn = var.cloudwatch_log_group_arn
  #   format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "routeKey" : "$context.routeKey", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength", "integrationError" : "$context.integrationErrorMessage" })
  # }

  dynamic "access_log_settings" {
    for_each = var.enable_cloudwatch_role ? [1] : []

    content {
      destination_arn = var.cloudwatch_log_group_arn
      format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "routeKey" : "$context.routeKey", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength", "integrationError" : "$context.integrationErrorMessage" })
    }
  }

  tags = var.tags
}
