variable "name" {
  description = "API Gateway name"
  type        = string
  default     = "default"
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
