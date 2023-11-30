resource "aws_sqs_queue" "queue" {
  name = format("%s-%s", local.product_name, var.name)

  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds

  redrive_policy = (var.redrive_max_receive_count != null) ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter[0].arn
    maxReceiveCount     = var.redrive_max_receive_count
  }) : null

  fifo_queue                  = var.fifo_queue
  content_based_deduplication = var.content_based_deduplication
  fifo_throughput_limit       = (var.fifo_queue) ? var.fifo_throughput_limit : null

  tags = var.tags
}

resource "aws_sqs_queue" "deadletter" {
  count = (var.redrive_max_receive_count != null) ? 1 : 0

  name = format("%s-%s-deadletter", local.product_name, var.name)

  tags = var.tags
}

resource "aws_sqs_queue_redrive_allow_policy" "deadletter" {
  count = (var.redrive_max_receive_count != null) ? 1 : 0

  queue_url = aws_sqs_queue.deadletter[0].id
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.queue.arn]
  })
}
