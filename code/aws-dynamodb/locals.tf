locals {
  product_name              = format("%s", var.tags["product"])
  product_path              = format("%s", var.tags["product"])
  product_name_multiregion  = format("%s-%s", var.tags["product"], var.tags["environment"])
  product_path_multiregion  = format("%s/%s", var.tags["product"], var.tags["environment"])
  resource_name             = format("%s-%s-%s", var.tags["product"], var.tags["project"], var.name)
  resource_path             = format("%s/%s/%s", var.tags["product"], var.tags["project"], var.name)
  resource_name_multiregion = format("%s-%s-%s-%s", var.tags["product"], var.tags["environment"], var.tags["project"], var.name)
  resource_path_multiregion = format("%s/%s/%s/%s", var.tags["product"], var.tags["environment"], var.tags["project"], var.name)
}
