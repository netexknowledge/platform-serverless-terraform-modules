variable "name" {
  description = "Name of API Gateway Authorizer"
  type        = string
  default     = "authorizer"
}

variable "parameters" {
  description = "API Gateway Authorizer parameters to be passed to the module"
  type        = any
  default = {
      lambda_name                      = "authorizer",
      identity_source                  = "method.request.header.Authorization"
      authorizer_result_ttl_in_seconds = 0
  }
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

variable "current_region" {
  description = "The current region"
  type        = string
  default     = ""
}

variable "current_awsaccount_id" {
  description = "The current AWS Account ID"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Default tags of resources to add"
  type = object({
    project     = string
    product     = string
    terraform   = string
    environment = string
  })

  default = {
    project     = null
    product     = null
    terraform   = null
    environment = null
  }
}
