variable "api_id" {
  description = "API Gateway ID"
  type        = string
  default     = ""
}

variable "triggers" {
  description = "Object of triggers of API Gateway deployment"
  type        = any
  default     = {}
}

variable "cloudwatch_log_group_arn" {
  description = "ARN of CloudWatch log group"
  type        = string
  nullable    = true
  default     = null
}

variable "stage_name" {
  description = "Name of API Gateway deployment stage"
  type        = string
  nullable    = true
  default     = "$default"
}

variable "enable_cloudwatch_role" {
  description = "Enable CloudWatch role in API Gateway setings account"
  type        = bool
  default     = false
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

variable "custom_domain" {
  type        = bool
  description = "Indicates whether to create a custom domain for the API."
  default     = false
}

variable "custom_domain_name" {
  type        = string
  description = "Name of the custom domain."
  default     = null
}

variable "base_path" {
  type        = string
  description = "Name concatenated by project and api name."
  default     = null
}

variable "waf_web_acl_name" {
  type        = string
  description = "Name of the WAF web ACL."
  default     = "SecurityACL"
}
