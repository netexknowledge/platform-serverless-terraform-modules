variable "parameters" {
  description = "Lamba parameters to be passed to the module"
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
  function_name         = try(var.parameters.function_name, "")
  handler               = try(var.parameters.handler, "")
  runtime               = try(var.parameters.runtime, "")
  timeout               = try(var.parameters.timeout, 3)
  source_path           = try(var.parameters.source_path, null)
  build_in_docker       = try(var.parameters.build_in_docker, false)
  docker_image          = try(var.parameters.docker_image, "")
  publish               = try(var.parameters.publish, false)
  environment_variables = try(var.parameters.environment_variables, {})
  allowed_triggers      = try(var.parameters.allowed_triggers, {})
  create_sam_metadata   = try(var.parameters.create_sam_metadata, false)
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
