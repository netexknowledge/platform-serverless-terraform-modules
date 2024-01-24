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
  description = "Glue Catalog database name"
  type        = string
}

variable "description" {
  description = "Glue Catalog database description"
  type        = string
  default     = ""
}

variable "location_uri" {
  description = "Glue Catalog database location URI"
  type        = string
  default     = null
}
