locals {
  base_table_parameters = var.parameters

  additional_table_parameters = tomap({
    classification       = var.data_format != null ? lower(var.data_format) : null
    useGlueParquetWriter = var.data_format == "parquet" ? "true" : null
  })

  # Filter out null values
  table_parameters = merge(
    local.base_table_parameters,
    { for k, v in local.additional_table_parameters : k => v if v != null }
  )

  serialization_libraries = {
    "csv"     = "org.apache.hadoop.hive.serde2.OpenCSVSerde",
    "json"    = "org.apache.hive.hcatalog.data.JsonSerDe",
    "xml"     = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe",
    "parquet" = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe",
    "orc"     = "org.apache.hadoop.hive.ql.io.orc.OrcSerde"
  }

  storage_descriptor_input_format = {
    "csv"     = "org.apache.hadoop.mapred.TextInputFormat",
    "json"    = "org.apache.hadoop.mapred.TextInputFormat",
    "xml"     = "org.apache.hadoop.mapred.TextInputFormat",
    "parquet" = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat",
    "orc"     = "org.apache.hadoop.hive.ql.io.orc.OrcInputFormat"
  }

  storage_descriptor_output_format = {
    "csv"     = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat",
    "json"    = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat",
    "xml"     = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat",
    "parquet" = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat",
    "orc"     = "org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat"
  }

  base_serde_parameters = var.serde_parameters

  additional_serde_parameters = tomap({
    "separatorChar" = lookup(var.serde_parameters, "separatorChar", var.data_format == "csv" ? "," : null)
  })

  # Filter out null values
  serde_parameters = merge(
    local.base_serde_parameters,
    { for k, v in local.additional_serde_parameters : k => v if v != null }
  )
}

resource "aws_glue_catalog_table" "catalog_table" {
  name        = local.resource_name
  description = var.description

  database_name = var.database_name
  catalog_id    = var.catalog_id

  table_type = var.table_type
  owner      = var.owner
  retention  = var.retention

  parameters = local.table_parameters

  storage_descriptor {
    location      = var.location
    input_format  = lookup(local.storage_descriptor_input_format, var.data_format, null)
    output_format = lookup(local.storage_descriptor_output_format, var.data_format, null)

    ser_de_info {
      name                  = local.resource_name
      serialization_library = lookup(local.serialization_libraries, var.data_format, null)
      parameters            = local.serde_parameters
    }

    dynamic "columns" {
      for_each = var.schema
      content {
        name       = columns.value.name
        type       = columns.value.type
        comment    = lookup(columns.value, "comment", "")
        parameters = lookup(columns.value, "parameters", {})
      }
    }
  }

  dynamic "partition_keys" {
    for_each = var.partition_keys
    content {
      name = partition_keys.value.name
      type = partition_keys.value.type
    }
  }

  dynamic "target_table" {
    for_each = var.target_table != null ? [1] : []
    content {
      catalog_id    = var.target_table.catalog_id
      database_name = var.target_table.database_name
      name          = var.target_table.name
    }
  }

  # dynamic "partition_index" {
  #   for_each = var.partition_index != null ? [1] : []
  #   content {
  #     index_name = var.partition_index.name
  #     keys       = var.partition_index.keys
  #   }
  # }
}

resource "aws_glue_partition_index" "catalog_table_partition_index" {
  count = var.partition_index != null ? 1 : 0

  database_name = var.database_name
  table_name    = aws_glue_catalog_table.catalog_table.name

  dynamic "partition_index" {
    for_each = var.partition_index != null ? [1] : []
    content {
      index_name = var.partition_index.name
      keys       = var.partition_index.keys
    }
  }
}
