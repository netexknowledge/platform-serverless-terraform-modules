# AWS S3
resource "aws_s3_bucket" "bucket" {
  bucket = format("netex-%s", local.resource_name)

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
    { Name = format("netex-%s", local.resource_name) },
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

resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  count = (var.lifecycle_rules != []) ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  dynamic "rule" {
    for_each = { for i, rule in var.lifecycle_rules : tostring(i) => rule }
    content {
      id     = lookup(rule.value, "id", "rule-${rule.key}")
      status = lookup(rule.value, "status", "Enabled")

      dynamic "filter" {
        for_each = lookup(rule.value, "filter", {}) != {} ? [1] : []
        content {
          prefix = lookup(rule.value.filter, "prefix", "")
          dynamic "tag" {
            for_each = lookup(rule.value.filter, "tag", {}) != {} ? [1] : []
            content {
              key   = rule.value.filter.tag.key
              value = rule.value.filter.tag.value
            }
          }
        }
      }

      dynamic "expiration" {
        for_each = lookup(rule.value, "expiration", {}) != {} ? [1] : []
        content {
          days                         = lookup(rule.value.expiration, "days", null)
          date                         = lookup(rule.value.expiration, "date", null)
          expired_object_delete_marker = lookup(rule.value.expiration, "expired_object_delete_marker", null)
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = lookup(rule.value, "noncurrent_version_expiration", {})
        content {
          noncurrent_days           = lookup(rule.value.noncurrent_version_expiration, "noncurrent_days", null)
          newer_noncurrent_versions = lookup(rule.value.noncurrent_version_expiration, "newer_noncurrent_versions", null)
        }
      }

      dynamic "abort_incomplete_multipart_upload" {
        for_each = lookup(rule.value, "abort_incomplete_multipart_upload", {})
        content {
          days_after_initiation = lookup(rule.value.abort_incomplete_multipart_upload, "days_after_initiation", null)
        }
      }

      dynamic "transition" {
        for_each = lookup(rule.value, "transition", {})
        content {
          days          = lookup(rule.value.transition, "days", null)
          storage_class = lookup(rule.value.transition, "storage_class", null)
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = lookup(rule.value, "noncurrent_version_transition", {})
        content {
          noncurrent_days           = lookup(rule.value.noncurrent_version_transition, "noncurrent_days", null)
          newer_noncurrent_versions = lookup(rule.value.noncurrent_version_transition, "newer_noncurrent_versions", null)
          storage_class             = lookup(rule.value.noncurrent_version_transition, "storage_class", null)
        }
      }
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "bucket-config" {
  count = (var.cors_rules != []) ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  dynamic "cors_rule" {
    for_each = { for i, rule in var.cors_rules : tostring(i) => rule }
    content {
      id              = lookup(cors_rule.value, "id", "rule-${cors_rule.key}")
      allowed_headers = lookup(cors_rule.value, "allowed_headers", null)
      allowed_methods = lookup(cors_rule.value, "allowed_methods", ["GET", "PUT", "HEAD", "POST", "DELETE"])
      allowed_origins = lookup(cors_rule.value, "allowed_origins", ["https://learningcloud.me"])
      expose_headers  = lookup(cors_rule.value, "expose_headers", null)
      max_age_seconds = lookup(cors_rule.value, "max_age_seconds", null)
    }
  }
}
