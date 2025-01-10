output "queue_arn" {
  description = "ARN of the created SQS queue"
  value       = aws_sqs_queue.queue.arn
}

output "apigateway_invoke_queue_arn" {
  description = "ARN uri service to use in invokes integrations of API Gateway"
  value       = "arn:aws:apigateway:${split(":", aws_sqs_queue.queue.arn)[3]}:sqs:path/${split(":", aws_sqs_queue.queue.arn)[4]}/${split(":", aws_sqs_queue.queue.arn)[5]}"

}
