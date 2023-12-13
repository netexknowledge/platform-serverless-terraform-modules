output "arn" {
  description = "Attributie ARN of the API Gateway Authorizer"
  value       = var.type == "REST" ? aws_api_gateway_authorizer.authorizer[0].arn : null
}

output "id" {
  description = "Attributie Authorizer identifier"
  value       = var.type == "REST" ? aws_api_gateway_authorizer.authorizer[0].id : aws_apigatewayv2_authorizer.authorizer[0].id
}
