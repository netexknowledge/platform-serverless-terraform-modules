output "queue_arn" {
  description = "ARN of the created SQS queue"
  value       = aws_sqs_queue.queue.arn
}
