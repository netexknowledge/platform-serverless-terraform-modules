output "resource" {
  description = "API Gateway resource"
  value       = aws_api_gateway_resource.resource
}

output "methods" {
  description = "API Gateway methods"
  value       = aws_api_gateway_method.methods

}

output "methods_id" {
  description = "Concatenated list of API Gateway Methods IDs"
  value       = join(",", [for value in aws_api_gateway_method.methods : value.id])
}

output "integrations" {
  description = "API Gateway integrations"
  value       = aws_api_gateway_integration.integrations
}

output "integrations_id" {
  description = "Concatenated list of API Gateway Integration IDs"
  value       = join(",", [for value in aws_api_gateway_integration.integrations : value.id])
}
