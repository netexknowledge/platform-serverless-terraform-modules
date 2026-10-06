output "topic_id" {
  description = "value of SNS topic id"
  value       = aws_sns_topic.user_updates.id
}

output "topic_arn" {
  description = "value of SNS topic arn"
  value       = aws_sns_topic.user_updates.arn
}
