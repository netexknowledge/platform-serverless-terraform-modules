output "resource" {
  description = "API Gateway resource"
  value = var.type == "REST" ? aws_api_gateway_resource.resource[0] : (var.type == "WEBSOCKET") ? {
    id : length(aws_apigatewayv2_route_response.responses) > 0 ? format("%s%s", aws_apigatewayv2_integration.integrations["default"].id, aws_apigatewayv2_route_response.responses["default"].id) : aws_apigatewayv2_integration.integrations["default"].id
  } : { "id" : "n/a" }
}

output "methods" {
  description = "API Gateway methods"
  value       = var.type == "REST" ? aws_api_gateway_method.methods : aws_apigatewayv2_route.methods
}

output "methods_id" {
  description = "Concatenated list of API Gateway Methods IDs"
  value       = var.type == "REST" ? join(",", [for value in aws_api_gateway_method.methods : value.id]) : join(",", [for value in aws_apigatewayv2_route.methods : value.id])
}

output "integrations" {
  description = "API Gateway integrations"
  value       = var.type == "REST" ? aws_api_gateway_integration.integrations : aws_apigatewayv2_integration.integrations
}

output "integrations_id" {
  description = "Concatenated list of API Gateway Integration IDs"
  value       = var.type == "REST" ? join(",", [for value in aws_api_gateway_integration.integrations : value.id]) : join(",", [for value in aws_apigatewayv2_integration.integrations : value.id])
}
