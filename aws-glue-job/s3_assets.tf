resource "random_string" "bucket_suffix" {
  length  = 6
  special = false
  lower   = true
  upper   = false
  numeric = true
}

# AWS S3 bucket to saved AWS Glue bucket to save job code script, results, ...
resource "aws_s3_bucket" "glue_bucket" {
  count = var.s3_create_bucket_glue ? 1 : 0

  bucket = var.s3_bucket_glue_name != null ? format("netex-%s-%s-%s-%s", var.tags.project, var.tags.environment, var.tags.product, var.s3_bucket_glue_name) : format("netex-%s-%s-%s-glue-bucket-%s", var.tags.project, var.tags.environment, var.tags.product, random_string.bucket_suffix.result)

  tags = merge(
    { Name = var.s3_bucket_glue_name != null ? format("netex-%s-%s-%s-%s", var.tags.project, var.tags.environment, var.tags.product, var.s3_bucket_glue_name) : format("netex-%s-%s-%s-glue-bucket-%s", var.tags.project, var.tags.environment, var.tags.product, random_string.bucket_suffix.result) },
    var.tags
  )
}

resource "aws_s3_bucket_ownership_controls" "glue_bucket" {
  count = var.s3_create_bucket_glue ? var.s3_acl != "private" ? 1 : 0 : 0

  bucket = aws_s3_bucket.glue_bucket[0].id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_acl" "glue_bucket" {
  count = var.s3_create_bucket_glue ? var.s3_acl != "private" ? 1 : 0 : 0

  bucket = aws_s3_bucket.glue_bucket[0].id
  acl    = var.s3_acl
}

resource "aws_s3_bucket_public_access_block" "glue_bucket" {
  count = var.s3_create_bucket_glue ? 1 : 0

  bucket = aws_s3_bucket.glue_bucket[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "glue_bucket" {
  count = var.s3_create_bucket_glue ? 1 : 0

  bucket = aws_s3_bucket.glue_bucket[0].id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowSSLRequestsOnly",
        "Action" : "s3:*",
        "Effect" : "Deny",
        "Resource" : [
          "${aws_s3_bucket.glue_bucket[0].arn}",
          "${aws_s3_bucket.glue_bucket[0].arn}/*"
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

resource "aws_s3_object" "glue_bucket_path" {
  count = var.script_file_path != null ? 1 : 0

  bucket = var.s3_create_bucket_glue ? aws_s3_bucket.glue_bucket[0].id : var.s3_bucket_glue_name
  key    = "scripts/${local.resource_name}/${basename(var.script_file_path)}"
  source = var.script_file_path

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.script_file_path)
}
