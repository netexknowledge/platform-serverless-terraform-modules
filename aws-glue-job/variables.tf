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
  description = "Glue Job name"
  type        = string
}

variable "s3_create_bucket_glue" {
  description = "Create S3 bucket storage for Glue job"
  type        = bool
  default     = false
}

variable "s3_bucket_glue_name" {
  description = "S3 bucket storage name for Glue job"
  type        = string
  default     = null
}

variable "s3_acl" {
  description = "S3 bucket storage for Glue job ACL"
  type        = string
  default     = "private"
}

variable "script_file_path" {
  description = "S3 bucket storage for Glue job script file path"
  type        = string
  default     = null
}

variable "glue_version" {
  description = "Glue job version. Valid values are 1.0, 2.0, 3.0 and 4.0. Deafult is 3.0"
  type        = string
  default     = "3.0"
}

variable "worker_type" {
  description = "Glue job worker type. Valid values are Standard, G.1X, G.2X, G.025X,  Z.2X. Default is G.1X"
  type        = string
  default     = "G.1X"
}

variable "custom_script_location_object_key" {
  description = "S3 bucket storage for Glue job custom script location object key"
  type        = string
  default     = ""
}

variable "number_of_workers" {
  description = "Glue job number of workers. Default is 2"
  type        = number
  default     = 2
}

variable "execution_class" {
  description = "Glue job execution class. Valid values are STANDARD or FLEX. Default is STANDARD"
  type        = string
  default     = "STANDARD"
}

variable "max_retries" {
  description = "Glue job max retries. Default is 0"
  type        = number
  default     = 0
}

variable "timeout" {
  description = "Glue job timeout execution in minutes. Default is 2880"
  type        = number
  default     = 2880
}

variable "max_concurrent_runs" {
  description = "Glue job max concurrent runs. Default is 1"
  type        = number
  default     = 1
}

variable "connections" {
  description = "Glue job connections list"
  type        = list(string)
}

variable "job_language" {
  description = "The language of the job. Default is python-3"
  type        = string
  default     = "python"
}

variable "auto_scale_within_microbatch" {
  description = "Auto scale within microbatch. Dafault is false"
  type        = string
  default     = "false"
}

variable "enable_job_insights" {
  description = "Enable job insights. Default is true"
  type        = string
  default     = "true"
}

variable "job_bookmark_option" {
  description = "Job bookmark option. Valid values are job-bookmark-disable, job-bookmark-enable, job-bookmark-allow-override. Default is job-bookmark-disable"
  type        = string
  default     = "job-bookmark-disable"
}

variable "enable_metrics" {
  description = "Enable metrics. Default is true"
  type        = string
  default     = "true"
}

variable "enable_observability_metrics" {
  description = "Enable observability metrics. Default is false"
  type        = string
  default     = "false"
}

variable "enable_continuous_cloudwatch_log" {
  description = "Enable continuous CloudWatch log. Default is true"
  type        = string
  default     = "true"
}

variable "enable_spark_ui" {
  description = "Enable Spark UI. Default is true"
  type        = string
  default     = "true"
}

variable "spark_event_logs_path" {
  description = "Path to Spark event logs"
  type        = string
  default     = null
}

variable "enable_continuous_log_filter" {
  description = "Enable continuous log filter. Default is true"
  type        = string
  default     = "true"
}

variable "enable_continuous_log_log_group" {
  description = "Enable continuous log log group"
  type        = string
  default     = ""
}

variable "enable_continuous_log_stream_name" {
  description = "Enable continuous log stream name"
  type        = string
  default     = ""
}

variable "enable_continuous_log_start_pattern" {
  description = "Enable continuous log start pattern. Default is LOG"
  type        = string
  default     = "LOG"
}

variable "temp_dir" {
  description = "Temporary directory"
  type        = string
  default     = null
}

variable "enable_glue_datacatalog" {
  description = "Enable Glue data catalog. Default is true"
  type        = string
  default     = "true"
}
