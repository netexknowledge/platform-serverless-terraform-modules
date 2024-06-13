variable "name" {
  description = "Name of API Gateway Resource"
  type        = string
  default     = "authorizer"
}

variable "parameters" {
  description = "API Gateway Resource parameters to be passed to the module"
  type        = any
  default = {
    http_method   = ["ANY"],
    authorizer    = null
    authorizer_id = null
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

variable "api_root_resource_id" {
  description = "API Gateway root resource id"
  type        = string
  default     = ""
}

variable "api_gateway_authorizer_id" {
  description = "API Gateway Authorizer ID"
  type        = string
  nullable    = true
  default     = null
}


variable "authorizer_id" {
  description = "API Gateway Authorizer ID pre-existing"
  type        = string
  nullable    = true
  default     = null
}

variable "lambda_function_invoke_arn" {
  description = "Lambda function invoke arn"
  type        = string
  nullable    = true
  default     = null
}

variable "lambda_function_invoke_arns_by_method" {
  description = "List of Lambda function invoke arn by method"
  type        = any
  nullable    = true
  default     = null
}

locals {
  name                       = substr(var.name, 0, 1) == "/" ? substr(var.name, 1, length(var.name) - 1) : var.name
  rest_http_methods          = var.type == "REST" ? lookup(var.parameters, "http_method", []) : []
  norest_http_methods        = var.type != "REST" ? lookup(var.parameters, "http_method", []) : []
  websocket_methods          = var.type == "WEBSOCKET" ? ["default"] : []
  websocket_response_methods = var.type == "WEBSOCKET" ? (lookup(var.parameters, "response", false) ? ["default"] : []) : []
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
