variable "name" {
  description = "Name to add to the DynamoDB table name, this should be converted to <tags.product>-<tags.environment>-<tags.project>-<this_value>"
  type        = string
  default     = "table"
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

variable "billing_mode" {
  description = "DynamoDB billing mode"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "read_capacity" {
  description = "DynamoDB read capacity"
  type        = number
  default     = null
}

variable "write_capacity" {
  description = "DynamoDB write capacity"
  type        = number
  default     = null
}

variable "stream_enabled" {
  description = "DynamoDB stream enabled"
  type        = bool
  default     = false
}

variable "point_in_time_recovery" {
  description = "DynamoDB point in time recovery"
  type        = bool
  default     = true
}

variable "attributes" {
  description = "List of DynamoDB table attributes"
  type = list(object({
    name = string
    type = string
  }))
}

variable "hash_key" {
  description = "DynamoDB table hash key"
  type        = string
}

variable "global_secondary_indexes" {
  description = "List of global secondary indexes"
  type        = any
  default     = []
}

variable "autoscaling" {
  description = "Enable autoscaling"
  type        = any
  default     = {}
}

variable "delete_protection" {
  description = "Enable delete protection for the DynamoDB table"
  type        = bool
  default     = true
}
