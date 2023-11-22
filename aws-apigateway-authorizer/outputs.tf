output "arn" {
  description = "Attributie ARN of the API Gateway Authorizer"
  value       = aws_api_gateway_authorizer.authorizer.arn
}

output "id" {
  description = "Attributie Authorizer identifier"
  value       = aws_api_gateway_authorizer.authorizer.id
}
