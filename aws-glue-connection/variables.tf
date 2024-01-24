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
  description = "Glue Connection name"
  type        = string
}

variable "description" {
  description = "Glue Connection description"
  type        = string
}

variable "catalog_id" {
  description = "Glue catalog ID"
  type        = string
  default     = null
}

variable "connection_type" {
  description = "Glue Connection type, default is JDBC. Valid values are JDBC, SFTP, MONGODB, KAFKA, NETWORK, MARKETPLACE, CUSTOM"
  type        = string
  default     = "JDBC"
}

variable "custom_connection_type" {
  description = "Glue Connection type for CUSTOM connection type"
  type        = string
  default     = ""
}

variable "jdbc_enforce_ssl" {
  description = "Glue Connection JDBC enforce SSL"
  type        = string
  default     = false
}

variable "jdbc_connection_url" {
  description = "Glue Connection JDBC connection URL"
  type        = string
  default     = ""
}

variable "connection_url" {
  description = "Glue Connection connection URL not JDBC"
  type        = string
  default     = ""
}

variable "secret_name" {
  description = "Glue Connection secret name"
  type        = string
  default     = ""
}

variable "username" {
  description = "Glue Connection username"
  type        = string
  default     = ""
}

variable "password" {
  description = "Glue Connection password"
  type        = string
  default     = ""

}

variable "connector_url" {
  description = "Glue Connection connector driver URL in S3 bucket"
  type        = string
  default     = ""
}

variable "connector_class_name" {
  description = "Glue Connection connector driver class name"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Glue Connection VPC Subnet ID"
  type        = string
}

variable "security_group_id_list" {
  description = "Glue Connection VPC Security Group ID list"
  type        = list(string)
}

variable "match_criteria" {
  description = "Glue Connection match criteria"
  type        = list(string)
  default     = []
}

variable "s3_create_bucket_drivers" {
  description = "Create S3 bucket to store AWS Glue connection drivers"
  type        = bool
  default     = false
}

variable "s3_bucket_drivers_name" {
  description = "S3 bucket name to store AWS Glue connection drivers, suffix when s3_create_bucket_drivers is true"
  type        = string
  default     = null
}

variable "s3_acl" {
  description = "S3 bucket ACL"
  type        = string
  default     = "private"
}

variable "connector_file_path" {
  description = "Path to connector driver file in S3 bucket"
  type        = string
  default     = null
}

variable "connector_file_name" {
  description = "Connector driver file name"
  type        = string
  default     = null
}
