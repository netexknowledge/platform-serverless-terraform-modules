variable "name" {
  description = "Name of API Gateway Authorizer, this should be converted to <tags.product>-<tags.environment>-<tags.project>-<this_value>"
  type        = string
  nullable    = false
  default     = "authorizer"
}

variable "parameters" {
  description = "API Gateway Authorizer parameters to be passed to the module. Allowed properties: lambda_name or lambda_authorizer_name, identity_source, authorizer_result_ttl_in_seconds and identity_validation_expression"
  type        = any
  nullable    = true
  default     = {}
}

variable "api_id" {
  description = "API Gateway ID"
  type        = string
  default     = ""
}

variable "api_name" {
  description = "API Gateway name"
  type        = string
  default     = ""
}

variable "lambda_function_invoke_arn" {
  description = "Lambda function invoke arn"
  type        = string
  nullable    = true
  default     = null
}

variable "lambda_function_arn" {
  description = "Lambda function arn"
  type        = string
  nullable    = true
  default     = null
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

variable "type" {
  description = "API Gateway type"
  type        = string
  default     = "REST"
}
