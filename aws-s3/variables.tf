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
  description = "Name of the S3 bucket"
  type        = string
}

variable "public_access" {
  description = "Enable public access to bucket"
  type        = bool
  default     = false
}

variable "object_ownership" {
  description = "Object ownership. Valid values are BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced"
  type        = string
  default     = "BucketOwnerEnforced"
}

variable "acl" {
  description = "bucket acl"
  type        = string
  default     = "private"
}

variable "versioning" {
  description = "Enable versioning"
  type        = bool
  default     = false
}

variable "prevent_destroy" {
  description = "Force destroy bucket"
  type        = bool
  default     = false
}

variable "notifications" {
  description = "values for bucket notifications"
  type        = any
  default     = {}
}

variable "lifecycle_rules" {
  description = "values for bucket lifecycle rules"
  type        = any
  default     = []
}
