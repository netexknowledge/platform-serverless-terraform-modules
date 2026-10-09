variable "name" {
  description = "API Gateway name, this should be converted to <tags.product>-<tags.environment>-<tags.project>-<this_value>"
  type        = string
  default     = "default"
}

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

variable "enable_cloudwatch_role" {
  description = "Enable CloudWatch role in API Gateway setings account"
  type        = bool
  default     = false
}

variable "custom_cloudwatch_role_arn" {
  description = "Custom CloudWatch role ARN"
  type        = string
  default     = null
}

variable "type" {
  description = "API Gateway type"
  type        = string
  default     = "REST"
}

variable "route_selection_expression" {
  description = "API Gateway route selection expression"
  type        = string
  default     = null
}

variable "endpoint_configuration_types" {
  description = "API Gateway endpoint configuration types"
  type        = string
  default     = "EDGE"
}

variable "binary_media_types" {
  description = "API Gateway binary media types"
  type        = list(string)
  nullable    = false
  default     = []
}

variable "security_policy" {
  description = <<-EOT
    TLS security policy for the REST API's own execute-api endpoint (only applies when
    var.type == "REST"; API Gateway doesn't support choosing a security policy for HTTP/
    WebSocket APIs, they're always fixed at TLS_1_2). null (default) picks the right enhanced
    policy automatically based on var.endpoint_configuration_types (the EDGE and REGIONAL/
    PRIVATE catalogs are different, see locals.default_rest_security_policy): TLS 1.2+1.3,
    only AEAD/PFS cipher suites, no CBC, no static RSA. Override only if a specific consumer
    needs a different policy.
  EOT
  type        = string
  default     = null

  # Comprobacion deliberadamente laxa: se valida el prefijo, no una lista de
  # politicas. AWS publica politicas nuevas cada pocos meses y enumerarlas aqui
  # convertiria cada una en un cambio del modulo. Asi se cazan las erratas de
  # capitalizacion o de formato, que es el fallo habitual, sin bloquear una
  # politica valida que todavia no exista.
  validation {
    condition     = var.security_policy == null || can(regex("^(SecurityPolicy_|TLS_)", var.security_policy))
    error_message = "security_policy debe empezar por SecurityPolicy_ (politicas mejoradas) o TLS_ (heredadas), o ser null para que el modulo elija la adecuada segun el tipo de endpoint."
  }
}

variable "endpoint_access_mode" {
  description = <<-EOT
    Required by AWS alongside any enhanced (non-legacy) security_policy value (confirmed
    against the real API: without it, update-rest-api/create-rest-api fails with
    "Endpoint access mode is required for the specified security policy"). "BASIC" doesn't
    restrict anything extra; "STRICT" adds origin/SNI checks AWS recommends once traffic is
    validated. Only applies when var.type == "REST", same as security_policy.
  EOT
  type        = string
  default     = "BASIC"

  # Aqui si procede enumerar: AWS solo admite estos dos valores y no es una
  # lista que crezca. Sin esto, una errata se descubre en el apply, con el
  # error opaco de la API en vez de en el plan.
  validation {
    condition     = contains(["BASIC", "STRICT"], var.endpoint_access_mode)
    error_message = "endpoint_access_mode debe ser BASIC o STRICT."
  }
}
