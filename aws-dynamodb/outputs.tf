output "table_arn" {
  description = "ARN of the created DynamoDB table"
  value       = aws_dynamodb_table.dynamodb_table.arn
}
