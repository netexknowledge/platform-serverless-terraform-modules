# AWS S3
resource "aws_s3_bucket_notification" "bucket_event" {
  count = (var.lambda_notifications != {}) ? 1 : 0

  bucket = var.bucket

  dynamic "lambda_function" {
    for_each = var.lambda_notifications
    content {
      id                  = lookup(lambda_function, "key", null)
      lambda_function_arn = lookup(lambda_function.value, "lambda_function_arn", null)
      events              = lookup(lambda_function.value, "events", ["s3:ObjectCreated:*"])
      filter_prefix       = lookup(lambda_function.value, "filter_prefix", null)
      filter_suffix       = lookup(lambda_function.value, "filter_suffix", null)
    }
  }
}
