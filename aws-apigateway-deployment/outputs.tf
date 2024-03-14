output "arn" {
  description = "ARN of the API Gateway"
  value       = var.type == "REST" ? aws_api_gateway_stage.stage[0].id : aws_apigatewayv2_stage.stage[0].id
}

output "invoke_url" {
  description = "Attributie invoke URL of the API Gateway"
  value       = var.type == "REST" ? aws_api_gateway_stage.stage[0].invoke_url : aws_apigatewayv2_stage.stage[0].invoke_url
}
