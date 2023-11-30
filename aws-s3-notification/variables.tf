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

variable "bucket" {
  description = "S3 bucket id"
  type        = string
}

variable "lambda_notifications" {
  description = "values for bucket notifications"
  type        = any
  default     = {}
}
