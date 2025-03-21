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
  description = "Glue Crawler name"
  type        = string
}

variable "type" {
  description = "value of the Crawler type. Valid values are jdbc, mongodb, s3 or catalog"
  type        = string
}

variable "database_name" {
  description = "Catalog Database name or id"
  type        = string
}

variable "description" {
  description = "Glue Crawler description"
  type        = string
  default     = ""
}

variable "role_arn" {
  description = "Glue Crawler role ARN"
  type        = string
}

variable "connection_name" {
  description = "Glue Crawler connection name"
  type        = string
  default     = null
}

variable "classifiers" {
  description = "Glue Crawler classifiers"
  type        = list(string)
  default     = []
}

variable "path" {
  description = "Glue Crawler path"
  type        = string
}

variable "database_name_target" {
  description = "Glue Crawler data catalog database name. Only use with type is catalog"
  type        = string
  default     = null
}

variable "tables" {
  description = "Glue Crawler tables. Only used when type is catalog"
  type        = list(string)
  default     = []
}

variable "schedule" {
  description = "Glue Crawler schedule"
  type        = string
  default     = null
}

variable "exclusions" {
  description = "Glue Crawler exclusions"
  type        = list(string)
  default     = []
}

variable "scan_all" {
  description = "Glue Crawler scan all. Only used when type is mongodb"
  type        = bool
  default     = true
}

variable "enable_additional_metadata" {
  description = "Specify a value of RAWTYPES or COMMENTS to enable additional metadata intable responses. RAWTYPES provides the native-level datatype. COMMENTS provides comments associated with a column or table in the database. Only used when type is jdbc"
  type        = list(string)
  default     = []
}
