terraform {
  required_version = ">= 1.0.4"

  required_providers {
    random = {
      source  = "random"
      version = "~> 3.6"
    }

    aws = {
      source = "hashicorp/aws"
      # Rango ancho a proposito, no un pin a 6.x: asi el modulo sirve tanto a
      # los repos que siguen en la rama 5 como a los que ya han subido, y cada
      # uno decide cuando migrar con el pin de su propio root. Ensanchar una
      # restriccion no rompe a nadie: quien fija ~> 5.37 sigue resolviendo 5.x.
      # El tope < 7.0 evita que un major futuro entre sin que nadie lo decida.
      version = ">= 5.37, < 7.0"
    }
  }
}
