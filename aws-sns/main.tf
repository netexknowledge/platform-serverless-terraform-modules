resource "aws_sns_topic" "user_updates" {
  name = format((var.fifo_topic) ? "%s-%s.fifo" : "%s-%s", local.product_name, var.name)

  delivery_policy             = var.delivery_policy
  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication

  tags = var.tags
}
