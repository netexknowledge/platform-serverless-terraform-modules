output "table_arn" {
  description = "ARN of the created DynamoDB table"
  value       = aws_dynamodb_table.dynamodb_table.arn
}

output "table_id" {
  description = "ID of the created DynamoDB table"
  value       = aws_dynamodb_table.dynamodb_table.id
}

output "table_stream_arn" {
  description = "ARN of the created DynamoDB table stream"
  value       = var.stream_enabled ? aws_dynamodb_table.dynamodb_table.stream_arn : null
}
