locals {
  # Las security policy mejoradas de API Gateway (TLS 1.2+1.3, solo cifrados AEAD/PFS) viven en
  # dos catalogos separados segun el tipo de endpoint: las *_EDGE son solo para
  # endpoint_configuration_types=EDGE, las que no llevan _EDGE son para REGIONAL/PRIVATE. Usar
  # el nombre equivocado para el tipo de endpoint falla al aplicar. Solo aplica a REST
  # (var.type == "REST"): API Gateway no deja elegir ninguna security policy mejorada para
  # HTTP/WebSocket (aws_apigatewayv2_api), que se queda fijo en TLS_1_2 siempre — limitacion de
  # AWS, no de este modulo. Hallazgo 2026-10-07 (auditoria SSL Labs).
  default_rest_security_policy = var.endpoint_configuration_types == "EDGE" ? "SecurityPolicy_TLS12_PFS_2025_EDGE" : "SecurityPolicy_TLS13_1_2_PFS_PQ_2025_09"

  product_name              = format("%s", var.tags["product"])
  product_path              = format("%s", var.tags["product"])
  product_name_multiregion  = format("%s-%s", var.tags["product"], var.tags["environment"])
  product_path_multiregion  = format("%s/%s", var.tags["product"], var.tags["environment"])
  resource_name             = format("%s-%s-%s", var.tags["product"], var.tags["project"], var.name)
  resource_path             = format("%s/%s/%s", var.tags["product"], var.tags["project"], var.name)
  resource_name_multiregion = format("%s-%s-%s-%s", var.tags["product"], var.tags["environment"], var.tags["project"], var.name)
  resource_path_multiregion = format("%s/%s/%s/%s", var.tags["product"], var.tags["environment"], var.tags["project"], var.name)
}
