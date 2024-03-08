output "arn" {
  description = "Attributie ARN of the API Gateway"
  value       = var.type == "REST" ? aws_api_gateway_rest_api.api[0].arn : aws_apigatewayv2_api.api[0].arn
}

output "name" {
  description = "Attributie name of the API Gateway"
  value       = local.resource_name
}

output "created_date" {
  description = "Attributie created date of the API Gateway"
  value       = var.type == "REST" ? aws_api_gateway_rest_api.api[0].created_date : null
}

output "execution_arn" {
  description = "Attributie execution ARN of the API Gateway"
  value       = var.type == "REST" ? aws_api_gateway_rest_api.api[0].execution_arn : aws_apigatewayv2_api.api[0].execution_arn
}

output "id" {
  description = "Attributie identifier of the API Gateway"
  value       = var.type == "REST" ? aws_api_gateway_rest_api.api[0].id : aws_apigatewayv2_api.api[0].id
}

output "root_resource_id" {
  description = "Attributie root resource id of the API Gateway"
  value       = var.type == "REST" ? aws_api_gateway_rest_api.api[0].root_resource_id : null
}

output "tags_all" {
  description = "A map of tags assigned to the API Gateway, including those inherited from the provider default_tags configuration block"
  value       = var.type == "REST" ? aws_api_gateway_rest_api.api[0].tags_all : aws_apigatewayv2_api.api[0].tags_all
}

output "cloudwatch_log_group_arn" {
  description = "Attributie ARN of CloudWatch log group"
  value       = aws_cloudwatch_log_group.logs.arn
}

output "cloudwatch_log_group_name" {
  description = "Attributie Name of CloudWatch log group"
  value       = aws_cloudwatch_log_group.logs.name
}

output "cloudwatch_log_group_tags_all" {
  description = "A map of tags assigned to the CloudWatch log group, including those inherited from the provider default_tags configuration block"
  value       = aws_cloudwatch_log_group.logs.tags_all
}
