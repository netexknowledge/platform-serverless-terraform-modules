locals {
  base_job_arguments = {}

  # Conditional addition of job_arguments
  additional_job_arguments = tomap({
    "--job-language"                        = var.job_language != "" ? var.job_language : null
    "--auto-scale-within-microbatch"        = var.auto_scale_within_microbatch != "" ? var.auto_scale_within_microbatch : null
    "--enable-job-insights"                 = var.enable_job_insights != "" ? var.enable_job_insights : null
    "--job-bookmark-option"                 = var.job_bookmark_option != "" ? var.job_bookmark_option : null
    "--enable-metrics"                      = var.enable_metrics != "" ? var.enable_metrics : null
    "--enable-observability-metrics"        = var.enable_observability_metrics != "" ? var.enable_observability_metrics : null
    "--enable-continuous-cloudwatch-log"    = var.enable_continuous_cloudwatch_log != "" ? var.enable_continuous_cloudwatch_log : null
    "--enable-spark-ui"                     = var.enable_spark_ui != "" ? var.enable_spark_ui : null
    "--spark-event-logs-path"               = var.s3_create_bucket_glue ? "s3://${aws_s3_bucket.glue_bucket[0].id}/sparkHistoryLogs/" : var.s3_bucket_glue_name != null ? "s3://${var.s3_bucket_glue_name}/sparkHistoryLogs/" : var.spark_event_logs_path
    "--enable-continuous-log-filter"        = var.enable_continuous_log_filter != "" ? var.enable_continuous_log_filter : null
    "--enable-continuous-log-log-group"     = var.enable_continuous_log_log_group != "" ? var.enable_continuous_log_log_group : "/aws-glue/jobs/${local.product_name}"
    "--enable-continuous-log-stream-name"   = var.enable_continuous_log_stream_name != "" ? var.enable_continuous_log_stream_name : "${var.name}"
    "--enable-continuous-log-start-pattern" = var.enable_continuous_log_start_pattern != "" ? var.enable_continuous_log_start_pattern : null
    "--TempDir"                             = var.s3_create_bucket_glue ? "s3://${aws_s3_bucket.glue_bucket[0].id}/temporary/" : var.s3_bucket_glue_name != null ? "s3://${var.s3_bucket_glue_name}/temporary/" : var.temp_dir
    "--enable-data-catalog"                 = var.enable_glue_datacatalog != "" ? var.enable_glue_datacatalog : null
    "--enable-glue-datacatalog"             = var.enable_glue_datacatalog != "" ? var.enable_glue_datacatalog : null
    "--s3_target_path"                      = var.s3_create_bucket_glue ? "s3://${aws_s3_bucket.glue_bucket[0].id}/output/" : var.s3_bucket_glue_name != null ? "s3://${var.s3_bucket_glue_name}/output/" : null
    "--list_connection_name"                = var.connections != null ? join(",", var.connections) : null
  })

  # Filter out null values
  connection_job_arguments = merge(
    local.base_job_arguments,
    { for k, v in local.additional_job_arguments : k => v if v != null }
  )
}

resource "aws_glue_job" "job" {
  name = var.name

  role_arn = aws_iam_role.glue_role.arn

  glue_version = var.glue_version
  worker_type  = var.worker_type

  command {
    name            = "glueetl"
    python_version  = null #"3.9"
    runtime         = null #"Ray2.4"
    script_location = var.script_file_path != null ? "s3://${aws_s3_bucket.glue_bucket[0].id}/${aws_s3_object.glue_bucket_path[0].id}" : var.custom_script_location_object_key
  }

  default_arguments = local.connection_job_arguments

  number_of_workers = var.number_of_workers
  execution_class   = var.execution_class
  max_retries       = var.max_retries
  timeout           = var.timeout
  execution_property {
    max_concurrent_runs = var.max_concurrent_runs
  }

  connections = var.connections

  security_configuration = null #aws_glue_security_configuration.example.name
}
