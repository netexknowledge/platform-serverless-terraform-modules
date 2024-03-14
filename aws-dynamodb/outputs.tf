output "table_arn" {
  description = "ARN of the created DynamoDB table"
  value       = aws_dynamodb_table.dynamodb_table.arn
}

output "table_id" {
  description = "ID of the created DynamoDB table"
  value       = aws_dynamodb_table.dynamodb_table.id
}
