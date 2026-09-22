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

variable "name" {
  description = "name of the SNS topic"
  type        = string
}

variable "delivery_policy" {
  description = "The SNS delivery policy"
  type        = string
  default     = null
}

variable "fifo_topic" {
  description = "Whether the SNS topic is FIFO"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Whether the SNS topic is content based deduplication"
  type        = bool
  default     = false
}
