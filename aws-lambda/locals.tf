data "aws_region" "current" {}

locals {
  product_name  = format("%s-%s", var.tags["product"], var.tags["environment"])
  product_path  = format("%s/%s", var.tags["product"], var.tags["environment"])
  resource_name = format("%s-%s-%s-%s", var.tags["product"], var.tags["environment"], var.tags["project"], var.parameters.function_name)
  resource_path = format("%s/%s/%s/%s", var.tags["product"], var.tags["environment"], var.tags["project"], var.parameters.function_name)
}
