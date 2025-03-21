resource "aws_sns_topic" "user_updates" {
  name = format((var.fifo_topic) ? "%s.fifo" : "%s", local.resource_name)

  delivery_policy             = var.delivery_policy
  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication

  tags = var.tags
}
