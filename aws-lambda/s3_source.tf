resource "random_string" "bucket_suffix" {
  length  = 6
  special = false
  lower   = true
  upper   = false
  numeric = true
}

# AWS S3 bucket to saved source code of Lambda
resource "aws_s3_bucket" "source_lambda" {
  count = local.store_on_s3 ? local.s3_create_bucket ? 1 : 0 : 0

  bucket = local.s3_bucket != null ? local.s3_bucket : format("netex-%s-%s-%s-lambda-source-%s", var.tags.project, var.tags.environment, var.tags.product, random_string.bucket_suffix)

  tags = merge(
    { Name = local.s3_bucket != null ? local.s3_bucket : format("netex-%s-%s-%s-lambda-source-%s", var.tags.project, var.tags.environment, var.tags.product, random_string.bucket_suffix) },
    var.tags
  )
}

resource "aws_s3_bucket_ownership_controls" "source_lambda" {
  count = local.store_on_s3 ? local.s3_create_bucket ? local.s3_acl != "private" ? 1 : 0 : 0 : 0

  bucket = aws_s3_bucket.source_lambda[0].id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_acl" "source_lambda" {
  count = local.store_on_s3 ? local.s3_create_bucket ? local.s3_acl != "private" ? 1 : 0 : 0 : 0

  bucket = aws_s3_bucket.source_lambda[0].id
  acl    = local.s3_acl
}

resource "aws_s3_bucket_public_access_block" "source_lambda" {
  count = local.store_on_s3 ? local.s3_create_bucket ? 1 : 0 : 0

  bucket = aws_s3_bucket.source_lambda[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "source_lambda" {
  count = local.store_on_s3 ? local.s3_create_bucket ? 1 : 0 : 0

  bucket = aws_s3_bucket.source_lambda[0].id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowSSLRequestsOnly",
        "Action" : "s3:*",
        "Effect" : "Deny",
        "Resource" : [
          "${aws_s3_bucket.source_lambda[0].arn}",
          "${aws_s3_bucket.source_lambda[0].arn}/*"
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
