# AWS S3
resource "aws_s3_bucket" "bucket" {
  bucket = format("%s-%s", local.product_name, var.bucket)

  # TODO: this not support: https://github.com/hashicorp/terraform/issues/22544
  # lifecycle {
  #   prevent_destroy = var.prevent_destroy
  # }

  # TODO: This option is not working, because prevent_destroy not support non static value
  # dynamic "lifecycle" {
  #   for_each = var.prevent_destroy ? [1] : []

  #   content {
  #     prevent_destroy = var.prevent_destroy
  #   }
  # }

  tags = merge(
    { Name = format("netex-%s", var.bucket) },
    var.tags
  )
}

resource "aws_s3_bucket_ownership_controls" "bucket" {
  count = var.acl != "private" ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_acl" "bucket" {
  count = var.acl != "private" ? 1 : 0

  bucket = aws_s3_bucket.bucket.id
  acl    = var.acl
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = !var.public_access
  block_public_policy     = !var.public_access
  ignore_public_acls      = !var.public_access
  restrict_public_buckets = !var.public_access
}

resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowSSLRequestsOnly",
        "Action" : "s3:*",
        "Effect" : "Deny",
        "Resource" : [
          "${aws_s3_bucket.bucket.arn}",
          "${aws_s3_bucket.bucket.arn}/*"
        ],
        "Condition" : {
          "Bool" : {
            "aws:SecureTransport" : "false"
          }
        },
        "Principal" : "*"
      }
    ]
  })
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  count = var.versioning ? 1 : 0

  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_notification" "bucket_event" {
  count = (var.notifications != {}) ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  dynamic "lambda_function" {
    for_each = var.notifications
    content {
      id                  = lookup(lambda_function, key, null)
      lambda_function_arn = lookup(lambda_function.value, lambda_arn, null)
      events              = lookup(lambda_function.value, events, ["s3:ObjectCreated:*"])
      filter_prefix       = lookup(lambda_function.value, filter_prefix, null)
      filter_suffix       = lookup(lambda_function.value, filter_suffix, null)
    }
  }
}
