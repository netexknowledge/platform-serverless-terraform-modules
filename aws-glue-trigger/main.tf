resource "aws_glue_trigger" "trigger" {
  name        = var.name
  description = var.description
  type        = "SCHEDULED"
  enabled     = var.enabled

  schedule = var.schedule

  actions {
    job_name               = local.actions.job_name
    arguments              = local.actions.arguments
    timeout                = local.actions.timeout
    security_configuration = local.actions.security_configuration

    dynamic "notification_property" {
      for_each = local.actions.notify_delay_after != null ? [1] : []
      content {
        notify_delay_after = local.actions.notify_delay_after
      }
    }
  }

  dynamic "predicate" {
    for_each = local.predicate.job_name != null ? [1] : []
    content {
      conditions {
        job_name         = local.predicate.job_name
        logical_operator = local.predicate.logical_operator
        state            = local.predicate.state
      }
    }
  }

  tags = var.tags
}
