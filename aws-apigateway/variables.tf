variable "name" {
  description = "API Gateway name"
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
