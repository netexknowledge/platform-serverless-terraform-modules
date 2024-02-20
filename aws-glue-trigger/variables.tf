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
  description = "Glue Trigger name"
  type        = string
}

variable "description" {
  description = "Glue Trigger description"
  type        = string
  default     = ""
}

variable "enabled" {
  description = "Glue Trigger"
  type        = bool
  default     = true
}

variable "schedule" {
  description = "Glue Crawler schedule"
  type        = string
  default     = null
}

variable "actions" {
  description = "Glue Trigger actions of job"
  type        = any
  # type        = object({
  #   job_name              = string
  #   arguments             = map(string)
  #   timeout               = number
  #   security_configuration = string
  #   notify_delay_after    = number
  # })
  default = {
    job_name               = null
    arguments              = null
    timeout                = null
    security_configuration = null
    notify_delay_after     = null
  }
}

variable "predicate" {
  description = "Glue Trigger predicate of job state"
  type        = any
  # type        = object({
  #   job_name         = string
  #   logical_operator = string
  #   state            = string
  # })
  default = {
    job_name         = null
    logical_operator = null
    state            = null
  }
  nullable = true
}

locals {
  actions = {
    job_name               = lookup(var.actions, "job_name", null)
    arguments              = lookup(var.actions, "arguments", null)
    timeout                = lookup(var.actions, "timeout", null)
    security_configuration = lookup(var.actions, "security_configuration", null)
    notification_property  = lookup(var.actions, "notification_property", null)
    notify_delay_after     = lookup(var.actions, "notify_delay_after", null)
  }

  predicate = {
    job_name         = var.predicate != null ? lookup(var.predicate, "job_name", null) : null
    logical_operator = var.predicate != null ? lookup(var.predicate, "logical_operator", null) : null
    state            = var.predicate != null ? lookup(var.predicate, "state", null) : null
  }
}
