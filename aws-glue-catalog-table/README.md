# Module: AWS Glue Catalog table

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.33.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.33.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_glue_catalog_table.catalog_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_table) | resource |
| [aws_glue_partition_index.catalog_table_partition_index](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_partition_index) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_catalog_id"></a> [catalog\_id](#input\_catalog\_id) | Glue catalog ID | `string` | `null` | no |
| <a name="input_data_format"></a> [data\_format](#input\_data\_format) | Choose the format of the data in your table. Valid values are avro, csv, json, xml, parquet and orc | `string` | `"csv"` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Glue Catalog database name | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Glue Catalog database description | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | Glue Catalog table bucket S3 source location | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Glue Catalog database name | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Glue Catalog database owner | `string` | `null` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | A map of key-value pairs to add as parameters to the table | `map(string)` | `{}` | no |
| <a name="input_partition_index"></a> [partition\_index](#input\_partition\_index) | Glue Catalog table partition index. Maximum 3 keys | <pre>object({<br>    name = string<br>    keys = list(string)<br>  })</pre> | `null` | no |
| <a name="input_partition_keys"></a> [partition\_keys](#input\_partition\_keys) | Glue Catalog table partition keys | <pre>list(object({<br>    name = string<br>    type = string<br>  }))</pre> | `[]` | no |
| <a name="input_retention"></a> [retention](#input\_retention) | Glue Catalog database retention | `number` | `null` | no |
| <a name="input_schema"></a> [schema](#input\_schema) | Glue Catalog table bucket S3 source scheme | `any` | `[]` | no |
| <a name="input_serde_parameters"></a> [serde\_parameters](#input\_serde\_parameters) | A map of key-value pairs to add as parameters to the table | `map(string)` | `{}` | no |
| <a name="input_table_type"></a> [table\_type](#input\_table\_type) | Glue Catalog table type. Valid values are EXTERNAL\_TABLE, VIRTUAL\_VIEW, and MANAGED\_TABLE | `string` | `"EXTERNAL_TABLE"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags of resources to add | <pre>object({<br>    project     = string<br>    product     = string<br>    terraform   = string<br>    environment = string<br>    samtemplate = string<br>  })</pre> | <pre>{<br>  "environment": null,<br>  "product": null,<br>  "project": null,<br>  "samtemplate": null,<br>  "terraform": null<br>}</pre> | no |
| <a name="input_target_table"></a> [target\_table](#input\_target\_table) | Glue Catalog database target table | <pre>object({<br>    catalog_id    = string<br>    database_name = string<br>    name          = string<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_catalog_table"></a> [catalog\_table](#output\_catalog\_table) | Glue catalog table |