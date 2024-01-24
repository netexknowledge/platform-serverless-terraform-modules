locals {
  product_name = format("%s-%s", var.tags["product"], var.tags["environment"])
  product_path = format("%s/%s", var.tags["product"], var.tags["environment"])
}
