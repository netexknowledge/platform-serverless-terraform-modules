output "arn" {
  description = "Attributie ARN of the API Gateway"
  value       = aws_api_gateway_rest_api.api.arn
}

output "created_date" {
  description = "Attributie created date of the API Gateway"
  value       = aws_api_gateway_rest_api.api.created_date
}

output "execution_arn" {
  description = "Attributie execution ARN of the API Gateway"
  value       = aws_api_gateway_rest_api.api.execution_arn
}

output "id" {
  description = "Attributie identifier of the API Gateway"
  value       = aws_api_gateway_rest_api.api.id
}

output "root_resource_id" {
  description = "Attributie root resource id of the API Gateway"
  value       = aws_api_gateway_rest_api.api.root_resource_id
}

output "tags_all" {
  description = "A map of tags assigned to the API Gateway, including those inherited from the provider default_tags configuration block"
  value       = aws_api_gateway_rest_api.api.tags_all
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
  value       = aws_api_gateway_rest_api.api.tags_all
}
