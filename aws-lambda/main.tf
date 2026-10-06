locals {
  aws_secrets_layers = {
    "us-west-1"    = ["arn:aws:lambda:us-west-1:997803712105:layer:AWS-Parameters-and-Secrets-Lambda-Extension:18"],
    "eu-central-1" = ["arn:aws:lambda:eu-central-1:187925254637:layer:AWS-Parameters-and-Secrets-Lambda-Extension:18"],
    "eu-west-1"    = ["arn:aws:lambda:eu-west-1:015030872274:layer:AWS-Parameters-and-Secrets-Lambda-Extension:18"]
  }

  datadog_layers = {
    "us-west-1" = {
      "python3.9"  = ["arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Python39:111", "arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Extension:82"],
      "python3.10" = ["arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Python310:111", "arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Extension:82"],
      "python3.11" = ["arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Python311:111", "arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Extension:82"],
      "python3.12" = ["arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Python312:111", "arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Extension:82"],
      "python3.13" = ["arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Python313:111", "arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs12.x" = ["arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Node12-x:88", "arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs14.x" = ["arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Node14-x:120", "arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs16.x" = ["arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Node16-x:123", "arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs18.x" = ["arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Node18-x:126", "arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs20.x" = ["arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Node20-x:126", "arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs22.x" = ["arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Node22-x:126", "arn:aws:lambda:us-west-1:464622532012:layer:Datadog-Extension:82"]
    }
    "eu-central-1" = {
      "python3.9"  = ["arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Python39:111", "arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Extension:82"],
      "python3.10" = ["arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Python310:111", "arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Extension:82"],
      "python3.11" = ["arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Python311:111", "arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Extension:82"],
      "python3.12" = ["arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Python312:111", "arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Extension:82"],
      "python3.13" = ["arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Python313:111", "arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs12.x" = ["arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Node12-x:88", "arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs14.x" = ["arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Node14-x:120", "arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs16.x" = ["arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Node16-x:123", "arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs18.x" = ["arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Node18-x:126", "arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs20.x" = ["arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Node20-x:126", "arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs22.x" = ["arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Node22-x:126", "arn:aws:lambda:eu-central-1:464622532012:layer:Datadog-Extension:82"]
    }
    "eu-west-1" = {
      "python3.9"  = ["arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Python39:111", "arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Extension:82"],
      "python3.10" = ["arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Python310:111", "arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Extension:82"],
      "python3.11" = ["arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Python311:111", "arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Extension:82"],
      "python3.12" = ["arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Python312:111", "arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Extension:82"],
      "python3.13" = ["arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Python313:111", "arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs12.x" = ["arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Node12-x:88", "arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs14.x" = ["arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Node14-x:120", "arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs16.x" = ["arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Node16-x:123", "arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs18.x" = ["arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Node18-x:126", "arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs20.x" = ["arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Node20-x:126", "arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Extension:82"],
      "nodejs22.x" = ["arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Node22-x:126", "arn:aws:lambda:eu-west-1:464622532012:layer:Datadog-Extension:82"]
    }
  }

  datadog_environment_variables = var.add_datadog_layer ? {
    "DD_ENV"                    = "${var.tags["environment"]}"
    "DD_API_KEY_SECRET_ARN"     = "${data.aws_secretsmanager_secret.datadog_apikey[0].arn}"
    "DD_SERVICE"                = "${local.resource_name}"
    "DD_LAMBDA_HANDLER"         = "${local.handler}"
    "DD_VERSION"                = "${var.version_lambda}${var.version_lambda_suffix}"
    "DD_CAPTURE_LAMBDA_PAYLOAD" = "true"
    "DD_MERGE_XRAY_TRACES"      = "false"
    "DD_SITE"                   = "datadoghq.eu"
    "DD_TRACE_ENABLED"          = "true"
    "DD_TAGS"                   = "team:${var.tags["product"]},env:${var.tags["environment"]},product:${var.tags["product"]},service:${local.resource_name},slot:default,platform:lambda,datacenter:aws,aws_account_name:netex_${var.tags["environment"]}"
  } : {}
}

module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.21.1"

  source_path = local.source_path
  # Por defecto el modulo interno recalcula el zip con un timestamp de "ahora"
  # en cada plan/apply, cambiando el hash aunque el codigo fuente no cambie:
  # eso fuerza un "update in-place" perpetuo de la lambda sin drift real.
  # Con esto en false, el zip solo cambia si cambia el contenido real.
  trigger_on_package_timestamp = false
  build_in_docker              = local.build_in_docker
  docker_image                 = local.docker_image
  docker_additional_options    = local.docker_additional_options
  function_name                = local.resource_name
  handler                      = local.handler
  runtime                      = local.runtime
  timeout                      = local.timeout
  memory_size                  = local.memory_size
  ephemeral_storage_size       = local.ephemeral_storage_size
  create_sam_metadata          = local.create_sam_metadata
  publish                      = local.publish
  environment_variables        = merge(local.environment_variables, local.datadog_environment_variables)
  store_on_s3                  = local.store_on_s3
  s3_acl                       = local.s3_acl
  s3_bucket                    = local.store_on_s3 ? local.s3_create_bucket ? aws_s3_bucket.source_lambda[0].id : local.s3_bucket : local.s3_bucket
  s3_existing_package          = local.s3_existing_package
  s3_prefix                    = local.s3_prefix
  s3_kms_key_id                = local.s3_kms_key_id
  s3_server_side_encryption    = local.s3_server_side_encryption
  s3_object_storage_class      = local.s3_object_storage_class

  cloudwatch_logs_log_group_class   = local.cloudwatch_logs_log_group_class
  cloudwatch_logs_retention_in_days = local.cloudwatch_logs_retention_in_days

  create_current_version_allowed_triggers = local.create_current_version_allowed_triggers
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

  event_source_mapping = {
    for trigger_name, trigger_config in var.allowed_triggers :
    trigger_name => merge(lookup(trigger_config, "event_source_mapping", {}),
      {
        event_source_arn = lookup(trigger_config, "source_arn", null)
    }) if length(lookup(trigger_config, "event_source_mapping", {})) > 0
  }

  attach_policy_statements = (var.policy_statements != {}) ? true : false
  policy_statements = merge(
    var.policy_statements,
    var.add_datadog_layer ? {
      DatadogAPIKeySecret = {
        actions   = ["secretsmanager:GetSecretValue"]
        resources = [data.aws_secretsmanager_secret.datadog_apikey[0].arn]
      }
    } : {}
  )

  # merge layers and layers_custom
  layers = concat(
    local.layers,
    var.add_datadog_layer ? local.datadog_layers[data.aws_region.current.name][local.runtime] : [],
    (var.add_secrets_layer || var.add_datadog_layer) ? local.aws_secrets_layers[data.aws_region.current.name] : [],
    [for layer_name, layer_config in module.lambda_layers :
      layer_config.lambda_layer_arn
    ]
  )

  role_name = "${local.resource_name}-role"

  vpc_security_group_ids = var.vpc_security_group_ids
  vpc_subnet_ids         = var.vpc_subnet_ids
  attach_network_policy  = true

  tags                 = var.tags
  role_tags            = var.tags
  s3_object_tags       = var.tags
  cloudwatch_logs_tags = var.tags
}

module "lambda_layers" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.21.1"

  for_each = local.layers_custom

  create_function     = false
  create_layer        = true
  layer_name          = lookup(each.value, "layer_name", format("%s-%s", local.resource_name, each.key))
  compatible_runtimes = lookup(each.value, "compatible_runtimes", [lookup(each.value, "runtime", local.runtime)])

  create_package         = lookup(each.value, "create_package", lookup(each.value, "local_existing_package_path", null) == null ? true : false)
  local_existing_package = lookup(each.value, "local_existing_package_path", null)

  source_path     = lookup(each.value, "source_path", null)
  build_in_docker = lookup(each.value, "build_in_docker", false)
  docker_image    = lookup(each.value, "docker_image", null)
  runtime         = lookup(each.value, "runtime", local.runtime)

  tags = var.tags
}
