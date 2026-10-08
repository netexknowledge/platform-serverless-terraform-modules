terraform {
  required_version = ">= 1.0.4"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      # Subido de ~> 5.37 a >= 6.0: security_policy/endpoint_access_mode en
      # aws_api_gateway_rest_api solo existen desde la rama 6.x del provider (confirmado: la
      # 5.100.0, la ultima 5.x, no los soporta). Bump de major version del provider — cada
      # consumidor (los *-terrasam-state) sigue fijado a ~> 5.37 en su propio root y tendra que
      # subir tambien su propio pin para poder adoptar esta version del modulo; no se tocan
      # esos 19 repos aqui, decision explicita del usuario (2026-10-07/08).
      version = ">= 6.0"
    }
  }
}
