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

variable "location_uri" {
  description = "Glue Catalog Database location URI"
  type        = string
  default     = null
}
