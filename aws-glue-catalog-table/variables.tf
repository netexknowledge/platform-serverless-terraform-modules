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
  description = "Glue Catalog Database name"
  type        = string
}

variable "description" {
  description = "Glue Catalog Database description"
  type        = string
  default     = ""
}

variable "database_name" {
  description = "Glue Catalog Database name"
  type        = string
}

variable "catalog_id" {
  description = "Glue catalog ID"
  type        = string
  default     = null
}

variable "table_type" {
  description = "Glue Catalog table type. Valid values are EXTERNAL_TABLE, VIRTUAL_VIEW, and MANAGED_TABLE"
  type        = string
  default     = "EXTERNAL_TABLE"
}

variable "owner" {
  description = "Glue Catalog Database owner"
  type        = string
  default     = null
}

variable "retention" {
  description = "Glue Catalog Database retention"
  type        = number
  default     = null
}

variable "target_table" {
  description = "Glue Catalog Database target table"
  type = object({
    catalog_id    = string
    database_name = string
    name          = string
  })
  default = null
}

variable "data_format" {
  description = "Choose the format of the data in your table. Valid values are avro, csv, json, xml, parquet and orc"
  type        = string
  default     = "csv"
}

variable "parameters" {
  description = "A map of key-value pairs to add as parameters to the table"
  type        = map(string)
  default     = {}
}

variable "serde_parameters" {
  description = "A map of key-value pairs to add as parameters to the table"
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "Glue Catalog table bucket S3 source location"
  type        = string
  default     = null
}

variable "schema" {
  description = "Glue Catalog table bucket S3 source scheme"
  type        = any
  # list(object({
  #   name         = string
  #   type         = string
  #   command      = string
  #   parameters   = map(string)
  # }))
  default = []
}

variable "partition_keys" {
  description = "Glue Catalog table partition keys"
  type = list(object({
    name = string
    type = string
  }))
  default = []
}

variable "partition_index" {
  description = "Glue Catalog table partition index. Maximum 3 keys"
  type = object({
    name = string
    keys = list(string)
  })
  default = null
}
