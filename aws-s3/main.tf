# AWS S3
resource "aws_s3_bucket" "bucket" {
  bucket = format("netex-%s", local.resource_name)

  # Sin esto, terraform no puede borrar un bucket que tenga algo dentro: AWS
  # responde BucketNotEmpty y el destroy muere a medias, dejando el stack en un
  # estado intermedio. Y como el versionado esta siempre activo mas abajo, "algo
  # dentro" incluye versiones antiguas y delete markers, no solo objetos
  # visibles.
  #
  # Por defecto false a proposito: que haga falta pedirlo de forma explicita es
  # lo unico que separa un "vacie el bloque del tfvars" de un borrado de datos.
  force_destroy = var.force_destroy

  # prevent_destroy de lifecycle NO sirve aqui: solo admite literales, no puede
  # leer una variable (hashicorp/terraform#22544, abierto desde 2019). Durante
  # anos este modulo tuvo esa intencion escrita en dos bloques comentados y una
  # variable prevent_destroy que no hacia absolutamente nada, mientras cinco
  # repos de estado la ponian a true creyendose protegidos. La proteccion real se
  # aplica ahora en la politica del bucket, mas abajo.

  lifecycle {
    precondition {
      condition     = !(var.force_destroy && var.prevent_destroy)
      error_message = "force_destroy y prevent_destroy se contradicen: uno borra el bucket con contenido y el otro prohibe borrarlo. Elige uno."
    }
  }

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
    "Statement" : concat([
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
      ],
      # Esta es la proteccion de verdad, la que lifecycle no puede dar: un Deny
      # explicito sobre s3:DeleteBucket. Aplica a todo el mundo, incluida la
      # cuenta, asi que para borrar el bucket hay que pasar antes prevent_destroy
      # a false y aplicar: dos pasos deliberados, igual que el
      # deletion_protection de DynamoDB. No bloquea DeleteBucketPolicy, asi que
      # quitar la proteccion sigue siendo un apply normal y no deja el bucket
      # irrecuperable.
      var.prevent_destroy ? [
        {
          "Sid" : "DenyDeleteBucket",
          "Action" : "s3:DeleteBucket",
          "Effect" : "Deny",
          "Resource" : ["${aws_s3_bucket.bucket.arn}"],
          "Principal" : "*"
        }
    ] : [])
  })
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  # count = var.versioning ? 1 : 0
  count = 1

  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_sns_topic" "s3_object_default_events" {
  count = (var.tags["environment"] != "tmp") ? (var.notifications != {}) ? 1 : 0 : 0

  name = format("s3-object-events-%s-topic", var.tags["environment"])
}

resource "aws_s3_bucket_notification" "bucket_event" {
  count = (var.notifications != {}) ? 1 : 0

  bucket = aws_s3_bucket.bucket.id

  dynamic "topic" {
    for_each = length(data.aws_sns_topic.s3_object_default_events) > 0 ? { "s3-object-default-events" : data.aws_sns_topic.s3_object_default_events[0] } : {}
    content {
      topic_arn = data.aws_sns_topic.s3_object_default_events[0].arn
      events    = ["s3:ObjectRestore:Completed"]
    }
  }

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
  # count = (var.lifecycle_rules != []) ? 1 : 0
  count = 1

  bucket = aws_s3_bucket.bucket.id

  rule {
    id     = "Expiration"
    status = "Enabled"

    filter {
      prefix = "temp/"
    }

    expiration {
      days = 1
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }

    noncurrent_version_expiration {
      noncurrent_days = 1
    }
  }

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

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket-config" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
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

resource "aws_s3_bucket_logging" "bucket" {
  count = (var.tags["environment"] != "tmp") ? 1 : 0

  bucket        = aws_s3_bucket.bucket.id
  target_bucket = format("netex-common-%s-s3-access-logs", var.tags["environment"])
  target_prefix = format("logs/netex-%s/", local.resource_name)
}
