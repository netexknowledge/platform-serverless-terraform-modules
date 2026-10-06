# Module: AWS Glue Catalog database

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
| [aws_glue_catalog_database.aws_glue_catalog_database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Glue Catalog Database description | `string` | `""` | no |
| <a name="input_location_uri"></a> [location\_uri](#input\_location\_uri) | Glue Catalog Database location URI | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Glue Catalog Database name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags of resources to add | <pre>object({<br>    project     = string<br>    product     = string<br>    terraform   = string<br>    environment = string<br>    samtemplate = string<br>  })</pre> | <pre>{<br>  "environment": null,<br>  "product": null,<br>  "project": null,<br>  "samtemplate": null,<br>  "terraform": null<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_catalog_database"></a> [catalog\_database](#output\_catalog\_database) | Glue catalog |