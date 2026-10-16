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
  description = "bucket ACL"
  type        = string
  default     = "private"
}

variable "versioning" {
  description = "Enable versioning"
  type        = bool
  default     = false
}

variable "prevent_destroy" {
  description = "Prohibe borrar el bucket: anade un Deny explicito sobre s3:DeleteBucket en la politica del bucket. Para borrarlo hay que ponerlo a false y aplicar primero. No usa lifecycle.prevent_destroy, que solo admite literales."
  type        = bool
  default     = false
}

variable "force_destroy" {
  description = "Permite a terraform borrar el bucket aunque tenga contenido, incluidas versiones antiguas y delete markers. Sin esto AWS responde BucketNotEmpty y el destroy falla a medias. Dejar en false salvo que se quiera borrar los datos a proposito."
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

variable "cors_rules" {
  description = "values for bucket cors rules"
  type        = any
  default     = []
}
