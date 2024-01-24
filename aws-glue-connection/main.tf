data "aws_subnet" "subnet" {
  id = var.subnet_id
}

locals {
  base_connection_properties = {}

  # Conditional addition of properties
  additional_properties = tomap({
    JDBC_CONNECTION_URL  = var.jdbc_connection_url != "" ? var.jdbc_connection_url : null
    CONNECTION_URL       = var.connection_url != "" ? var.connection_url : null
    CONNECTION_TYPE      = var.custom_connection_type != "" ? var.custom_connection_type : null
    SECRET_ID            = var.secret_name != "" ? var.secret_name : null
    USERNAME             = var.username != "" ? var.username : null
    PASSWORD             = var.password != "" ? var.password : null
    CONNECTOR_URL        = var.connector_file_path != null ? aws_s3_object.glue_driver_path[0].id : var.connector_url != "" ? var.connector_url : null # "s3://netex-bre-poc/tmp/mysql-connector-j-8.1.0.jar"
    CONNECTOR_CLASS_NAME = var.connector_class_name != "" ? var.connector_class_name : null                                                            # "com.mysql.cj.jdbc.Driver"
    JDBC_ENFORCE_SSL     = var.jdbc_enforce_ssl != "" ? var.jdbc_enforce_ssl : null
  })

  # Filter out null values
  connection_properties = merge(
    local.base_connection_properties,
    { for k, v in local.additional_properties : k => v if v != null }
  )
}

resource "aws_glue_connection" "connection" {
  name        = var.name
  description = var.description

  catalog_id = var.catalog_id

  connection_type = var.connection_type

  connection_properties = local.connection_properties

  physical_connection_requirements {
    subnet_id              = data.aws_subnet.subnet.id
    availability_zone      = data.aws_subnet.subnet.availability_zone
    security_group_id_list = var.security_group_id_list
  }

  match_criteria = var.match_criteria

  tags = var.tags
}
