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
  description = "Name of SQS queue"
  type        = string
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default is 0 (zero)."
  type        = number
  default     = 0
}

variable "redrive_max_receive_count" {
  description = "The maximum number of times a message can be received before being sent to the dead letter queue. If not set, the default value is 5."
  type        = number
  default     = null
}

variable "max_message_size" {
  description = "Specifies the limit of how many bytes a message can contain before Amazon SQS rejects it. Valid values: An integer from 1,024 bytes (1 KiB) to 262,144 bytes (256 KiB). The default value is 262,144 (256 KiB)."
  type        = number
  default     = 262144
}

variable "message_retention_seconds" {
  description = "Specifies the number of seconds that Amazon SQS retains a message. You can specify an integer value from 60 seconds (1 minute) to 1,209,600 seconds (14 days). The default value is 345,600 seconds (4 days)."
  type        = number
  default     = 345600
}

variable "receive_wait_time_seconds" {
  description = "Specifies the duration, in seconds, that the ReceiveMessage action call waits until a message is in the queue to include in the response, as opposed to returning an empty response if a message is not yet available."
  type        = number
  default     = 0
}

variable "visibility_timeout_seconds" {
  description = "Specifies the visibility timeout for the queue, in seconds. Valid values: An integer from 0 to 43,200 (12 hours). The default is 30."
  type        = number
  default     = 30
}

variable "fifo_queue" {
  description = "Specifies whether to create a FIFO queue. If you don't specify this property, Amazon SQS creates a standard queue."
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Specifies whether to enable content-based deduplication. During the deduplication interval (5 minutes), Amazon SQS treats messages that are sent with identical content (excluding attributes) as duplicates and delivers only one copy of the message."
  type        = bool
  default     = false
}

variable "fifo_throughput_limit" {
  description = "Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. Valid values are perQueue (default) and perMessageGroupId."
  type        = string
  default     = "perMessageGroupId"
}
