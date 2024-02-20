# Module: AWS Glue Crawler

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.37 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.37 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_glue_crawler.crawler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_crawler) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_classifiers"></a> [classifiers](#input\_classifiers) | Glue Crawler classifiers | `list(string)` | `[]` | no |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Glue Crawler connection name | `string` | `null` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Catalog database name or id | `string` | n/a | yes |
| <a name="input_database_name_target"></a> [database\_name\_target](#input\_database\_name\_target) | Glue Crawler data catalog database name. Only use with type is catalog | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Glue Crawler description | `string` | `""` | no |
| <a name="input_enable_additional_metadata"></a> [enable\_additional\_metadata](#input\_enable\_additional\_metadata) | Specify a value of RAWTYPES or COMMENTS to enable additional metadata intable responses. RAWTYPES provides the native-level datatype. COMMENTS provides comments associated with a column or table in the database. Only used when type is jdbc | `list(string)` | `[]` | no |
| <a name="input_exclusions"></a> [exclusions](#input\_exclusions) | Glue Crawler exclusions | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Glue Crawler name | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Glue Crawler path | `string` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | Glue Crawler role ARN | `string` | n/a | yes |
| <a name="input_scan_all"></a> [scan\_all](#input\_scan\_all) | Glue Crawler scan all. Only used when type is mongodb | `bool` | `true` | no |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | Glue Crawler schedule | `string` | `null` | no |
| <a name="input_tables"></a> [tables](#input\_tables) | Glue Crawler tables. Only used when type is catalog | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags of resources to add | <pre>object({<br>    project     = string<br>    product     = string<br>    terraform   = string<br>    environment = string<br>    samtemplate = string<br>  })</pre> | <pre>{<br>  "environment": null,<br>  "product": null,<br>  "project": null,<br>  "samtemplate": null,<br>  "terraform": null<br>}</pre> | no |
| <a name="input_type"></a> [type](#input\_type) | value of the Crawler type. Valid values are jdbc, mongodb, s3 or catalog | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_crawler"></a> [crawler](#output\_crawler) | Glue Crawler |