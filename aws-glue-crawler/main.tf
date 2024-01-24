resource "aws_glue_crawler" "crawler" {
  name = var.name

  database_name = var.database_name

  role = var.role_arn

  classifiers = var.classifiers

  dynamic "s3_target" {
    for_each = var.type == "s3" ? [1] : []
    content {
      connection_name = var.connection_name
      path            = var.path
      exclusions      = var.exclusions
    }
  }

  dynamic "jdbc_target" {
    for_each = var.type == "jdbc" ? [1] : []
    content {
      connection_name            = var.connection_name
      path                       = var.path
      exclusions                 = var.exclusions
      enable_additional_metadata = var.enable_additional_metadata
    }
  }

  dynamic "mongodb_target" {
    for_each = var.type == "mongodb" ? [1] : []
    content {
      connection_name = var.connection_name
      path            = var.path
      scan_all        = var.scan_all
    }
  }

  dynamic "catalog_target" {
    for_each = var.type == "catalog" ? [1] : []
    content {
      database_name = var.database_name_target
      tables        = var.tables
    }
  }

  schedule = var.schedule

  tags = var.tags
}
