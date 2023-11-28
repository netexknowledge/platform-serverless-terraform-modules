module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "6.0.1"

  timeout               = local.timeout
  source_path           = local.source_path
  build_in_docker       = local.build_in_docker
  docker_image          = local.docker_image
  function_name         = local.function_name
  handler               = local.handler
  runtime               = local.runtime
  create_sam_metadata   = local.create_sam_metadata
  publish               = local.publish
  environment_variables = local.environment_variables
  allowed_triggers = {
    for trigger_name, trigger_config in var.allowed_triggers :
    trigger_name => {
      statement_id       = try(trigger_config.statement_id, null)
      action             = try(trigger_config.action, "lambda:InvokeFunction")
      service            = try(trigger_config.service, null)
      principal          = try(trigger_config.principal, format("%s.amazonaws.com", try(trigger_config.service, "")))
      principal_org_id   = try(trigger_config.principal_org_id, null)
      source_arn         = try(trigger_config.source_arn, null) #replace(try(trigger_config.source_arn, null), "__dollar__", "$")
      source_account     = try(trigger_config.source_account, null)
      event_source_token = try(trigger_config.event_source_token, null)
    }
  }

  attach_policy_statements = (var.policy_statements != {}) ? true : false
  policy_statements        = var.policy_statements

  tags                 = var.tags
  role_tags            = var.tags
  s3_object_tags       = var.tags
  cloudwatch_logs_tags = var.tags
}
