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
    # for_each = var.enable_cloudwatch_role ? [1] : []
    for_each = [1]

    content {
      destination_arn = var.cloudwatch_log_group_arn
      # format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "routeKey" : "$context.routeKey", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength", "integrationError" : "$context.integrationErrorMessage" })
      format = jsonencode({
        requestId    = "$context.requestId" # This field is required
        errorMessage = "$context.error.message"
        status       = "$context.status"
      })
    }
  }

  tags = var.tags
}

resource "aws_api_gateway_method_settings" "deployment" {
  count = var.type == "REST" ? 1 : 0

  rest_api_id = var.api_id
  stage_name  = aws_api_gateway_stage.stage[0].stage_name
  method_path = "*/*" # Apply to all resources and methods

  settings {
    logging_level      = "ERROR" # Log only errors (options: OFF, INFO, ERROR)
    metrics_enabled    = false
    data_trace_enabled = false
  }
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

  # For HTTP APIs
  dynamic "default_route_settings" {
    for_each = var.type == "HTTP" ? [1] : []

    content {
      detailed_metrics_enabled = false
      logging_level            = "ERROR"
    }
  }

  # For WebSocket APIs
  dynamic "route_settings" {
    for_each = var.type == "WEBSOCKET" ? toset(["$default", "$connect", "$disconnect"]) : []

    content {
      route_key                = route_settings.value
      logging_level            = "ERROR"
      detailed_metrics_enabled = false
    }
  }

  dynamic "access_log_settings" {
    # for_each = var.enable_cloudwatch_role ? [1] : []
    for_each = [1]

    content {
      destination_arn = var.cloudwatch_log_group_arn
      # format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "routeKey" : "$context.routeKey", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength", "integrationError" : "$context.integrationErrorMessage" })
      format = jsonencode({
        requestId    = "$context.requestId" # This field is required
        errorMessage = "$context.error.message"
        status       = "$context.status"
      })
    }
  }

  tags = var.tags
}

resource "aws_api_gateway_base_path_mapping" "custom_mapping" {
  count = (var.custom_domain == true && var.type == "REST") ? 1 : 0

  api_id      = var.api_id
  stage_name  = aws_api_gateway_stage.stage[0].stage_name
  domain_name = var.custom_domain_name
  base_path   = var.base_path
}

resource "aws_apigatewayv2_api_mapping" "custom_mapping" {
  count = (var.custom_domain == true && var.type != "REST") ? 1 : 0

  api_id          = var.api_id
  stage           = aws_apigatewayv2_stage.stage[0].id
  domain_name     = var.custom_domain_name
  api_mapping_key = var.base_path
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_waf_web_acl" "ApiGatewayACL" {
  count = (var.tags["environment"] != "tmp") ? 1 : 0

  name = var.waf_web_acl_name
}

resource "aws_wafv2_web_acl_association" "waf_association" {
  count = (var.tags["environment"] != "tmp") ? 1 : 0

  resource_arn = var.type == "REST" ? aws_api_gateway_stage.stage[0].arn : aws_apigatewayv2_stage.stage[0].arn
  web_acl_arn  = format("arn:aws:wafv2:%s:%s:webacl/%s", data.aws_region.current.name, data.aws_caller_identity.current.account_id, data.aws_waf_web_acl.ApiGatewayACL[0].id)
}
