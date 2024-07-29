variable "name" {
  description = "API Gateway name, this should be converted to <tags.product>-<tags.environment>-<tags.project>-<this_value>"
  type        = string
  default     = "default"
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

variable "enable_cloudwatch_role" {
  description = "Enable CloudWatch role in API Gateway setings account"
  type        = bool
  default     = false
}

variable "custom_cloudwatch_role_arn" {
  description = "Custom CloudWatch role ARN"
  type        = string
  default     = null
}

variable "type" {
  description = "API Gateway type"
  type        = string
  default     = "REST"
}

variable "route_selection_expression" {
  description = "API Gateway route selection expression"
  type        = string
  default     = null
}

variable "endpoint_configuration_types" {
  description = "API Gateway endpoint configuration types"
  type        = string
  default     = "EDGE"
}
