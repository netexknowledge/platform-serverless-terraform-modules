#######################################
## Resources endpoints               ##
#######################################

resource "aws_api_gateway_resource" "resource" {
  count = var.type == "REST" ? 1 : 0

  rest_api_id = var.api_id
  parent_id   = var.api_root_resource_id
  path_part   = substr(var.name, 0, 1) == "/" ? substr(var.name, 1, length(var.name) - 1) : var.name
}

resource "aws_api_gateway_method" "methods" {
  for_each = toset(local.rest_http_methods)

  rest_api_id   = var.api_id
  resource_id   = aws_api_gateway_resource.resource[0].id
  http_method   = each.key
  authorization = ((lookup(var.parameters, "authorizer", false) == true) || (lookup(var.parameters, "authorizer_id", null) != null)) ? "CUSTOM" : "NONE"
  authorizer_id = var.authorizer_id != null ? var.authorizer_id : var.api_gateway_authorizer_id
}

resource "aws_api_gateway_integration" "integrations" {
  for_each = toset(local.rest_http_methods)

  rest_api_id             = var.api_id
  resource_id             = aws_api_gateway_resource.resource[0].id
  http_method             = aws_api_gateway_method.methods[each.key].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  content_handling        = "CONVERT_TO_TEXT"
  uri                     = var.lambda_function_invoke_arn
}

resource "aws_apigatewayv2_integration" "integrations" {
  for_each = var.type == "HTTP" ? toset(local.norest_http_methods) : toset(local.websocket_methods)

  api_id           = var.api_id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  content_handling_strategy = var.type == "WEBSOCKET" ? "CONVERT_TO_TEXT" : null
  integration_method        = "POST"
  integration_uri           = var.lambda_function_invoke_arn
  passthrough_behavior      = var.type == "WEBSOCKET" ? "WHEN_NO_MATCH" : null
  timeout_milliseconds      = lookup(var.parameters, "timeout_milliseconds", null)
}

resource "aws_apigatewayv2_route" "methods" {
  for_each = var.type == "HTTP" ? toset(local.norest_http_methods) : toset(local.websocket_methods)

  api_id    = var.api_id
  route_key = var.type == "HTTP" ? format("%s %s", each.key, var.name) : substr(var.name, 0, 1) == "/" ? substr(var.name, 1, length(var.name) - 1) : var.name

  route_response_selection_expression = contains(local.websocket_response_methods, each.key) ? "$default" : null

  target = "integrations/${aws_apigatewayv2_integration.integrations[each.key].id}"
}

# resource "aws_apigatewayv2_integration_response" "example" {
#   for_each = toset(local.websocket_response_methods)

#   api_id                   = var.api_id
#   integration_id           = aws_apigatewayv2_route.methods[each.key].id
#   integration_response_key = "$default"
# }

resource "aws_apigatewayv2_route_response" "responses" {
  for_each = toset(local.websocket_response_methods)

  api_id             = var.api_id
  route_id           = aws_apigatewayv2_route.methods[each.key].id
  route_response_key = "$default"
}
