terraform {
  required_version = ">= 1.0.4"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      # Subido de ~> 5.37 a >= 6.0: security_policy/endpoint_access_mode en
      # aws_api_gateway_rest_api solo existen desde la rama 6.x del provider (confirmado: la
      # 5.100.0, la ultima 5.x, no los soporta).
      #
      # Esto rompe a los consumidores, y de ahi que el modulo pase a major 2.x: los 21 repos
      # que lo usan fijan ~> 5.37 en su propio root, y terraform resuelve el provider como la
      # INTERSECCION de todas las restricciones, modulos incluidos. ~> 5.37 interseccion
      # >= 6.0 es vacio, asi que su terraform init falla con "no available provider versions
      # match" antes de llegar a ningun plan.
      #
      # Por eso no vale publicarlo como minor: los consumidores apuntan a la tag flotante
      # aws-apigateway@1, que se moveria debajo de ellos. Con 2.0.0, @1 se queda donde esta y
      # cada repo migra a @2 cuando haya subido su propio pin del provider.
      version = ">= 6.0"
    }
  }
}
