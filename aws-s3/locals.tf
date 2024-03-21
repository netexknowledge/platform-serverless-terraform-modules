locals {
  product_name  = format("%s-%s", var.tags["product"], var.tags["environment"])
  product_path  = format("%s/%s", var.tags["product"], var.tags["environment"])
  resource_name = format("%s-%s-%s-%s", var.tags["product"], var.tags["environment"], var.tags["project"], var.bucket)
  resource_path = format("%s/%s/%s/%s", var.tags["product"], var.tags["environment"], var.tags["project"], var.bucket)
}
