variable "version_lambda" {
  description = "Version of lambada function"
  type        = string
  default     = "0.0.1"
}

variable "parameters" {
  description = "Lamba parameters to be passed to the module. The function_name should be converted to <tags.product>-<tags.environment>-<tags.project>-<value_of_function_name>"
  type        = any
  default = {
    function_name       = "",
    handler             = "",
    runtime             = "",
    timeout             = 3,
    source_path         = null,
    build_in_docker     = false,
    docker_image        = "",
    publish             = false,
    allowed_triggers    = {},
    create_sam_metadata = false
  }
}

variable "allowed_triggers" {
  description = "Allowed triggers to add the lambda"
  type        = any
  default     = {}
}

variable "lambdas_permissions" {
  description = "Permissions to add to the lambda"
  type        = any
  default     = {}
}

locals {
  function_name             = try(var.parameters.function_name, "")
  handler                   = try(var.parameters.handler, "")
  runtime                   = try(var.parameters.runtime, "")
  timeout                   = try(var.parameters.timeout, 3)
  memory_size               = try(var.parameters.memory_size, 128)
  ephemeral_storage_size    = try(var.parameters.ephemeral_storage_size, 512)
  source_path               = try(var.parameters.source_path, null)
  build_in_docker           = try(var.parameters.build_in_docker, false)
  docker_image              = try(var.parameters.docker_image, "")
  docker_additional_options = try(var.parameters.docker_additional_options, [])
  publish                   = try(var.parameters.publish, false)
  environment_variables     = try(var.parameters.environment_variables, {})
  allowed_triggers          = try(var.parameters.allowed_triggers, {})
  create_sam_metadata       = try(var.parameters.create_sam_metadata, false)
  layers                    = try(var.parameters.layers, [])
  layers_custom             = try(var.parameters.layers_custom, {})
  store_on_s3               = try(var.parameters.store_on_s3, false)
  s3_create_bucket          = try(var.parameters.s3_create_bucket, false)
  s3_acl                    = try(var.parameters.s3_acl, "private")
  s3_bucket                 = try(var.parameters.s3_bucket, null)
  s3_existing_package       = try(var.parameters.s3_existing_package, null)
  s3_prefix                 = try(var.parameters.s3_prefix, null)
  s3_kms_key_id             = try(var.parameters.s3_kms_key_id, null)
  s3_server_side_encryption = try(var.parameters.s3_server_side_encryption, null)
  s3_object_storage_class   = try(var.parameters.s3_object_storage_class, "ONEZONE_IA")
}

variable "tags" {
  description = "Default tags of resources to add"
  type = object({
    project     = string
    product     = string
    terraform   = string
    environment = string
    samtemplate = string
  })

  default = {
    project     = null
    product     = null
    terraform   = null
    environment = null
    samtemplate = null
  }
}

variable "policy_statements" {
  description = "Policies statetements with permissions to add to the lambda function role"
  type        = any
  default     = {}
}

variable "add_secrets_layer" {
  description = "Enable AWS secrets layer"
  type        = bool
  default     = false
}

variable "add_datadog_layer" {
  description = "Enable Datadog layer"
  type        = bool
  default     = false
}
