resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = local.resource_name

  description = var.description

  location_uri = var.location_uri

  tags = var.tags
}
