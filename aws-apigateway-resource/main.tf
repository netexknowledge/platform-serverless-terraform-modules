#######################################
## Resources endpoints               ##
#######################################

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = var.api_id
  parent_id   = var.api_root_resource_id
  path_part   = substr(var.name, 0, 1) == "/" ? substr(var.name, 1, length(var.name) - 1) : var.name
}

resource "aws_api_gateway_method" "methods" {
  for_each = toset(var.parameters.http_method)

  rest_api_id   = var.api_id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = each.key
  authorization = ((lookup(var.parameters, "authorizer", false) == true) || (lookup(var.parameters, "authorizer_id", null) != null)) ? "CUSTOM" : "NONE"
  authorizer_id = var.authorizer_id != null ? var.authorizer_id : var.api_gateway_authorizer_id
}

resource "aws_api_gateway_integration" "integrations" {
  for_each = toset(var.parameters.http_method)

  rest_api_id             = var.api_id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.methods[each.key].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  content_handling        = "CONVERT_TO_TEXT"
  uri                     = var.lambda_function_invoke_arn
}
