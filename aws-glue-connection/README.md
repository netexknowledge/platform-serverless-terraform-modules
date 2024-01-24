# Module: AWS Glue Connection

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
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_glue_connection.connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_connection) | resource |
| [aws_s3_bucket.glue_drivers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.glue_drivers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_ownership_controls.glue_drivers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.glue_drivers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.glue_drivers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_object.glue_driver_path](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [random_string.bucket_suffix](https://registry.terraform.io/providers/random/latest/docs/resources/string) | resource |
| [aws_subnet.subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_catalog_id"></a> [catalog\_id](#input\_catalog\_id) | Glue catalog ID | `string` | `null` | no |
| <a name="input_connection_type"></a> [connection\_type](#input\_connection\_type) | Glue Connection type, default is JDBC. Valid values are JDBC, SFTP, MONGODB, KAFKA, NETWORK, MARKETPLACE, CUSTOM | `string` | `"JDBC"` | no |
| <a name="input_connection_url"></a> [connection\_url](#input\_connection\_url) | Glue Connection connection URL not JDBC | `string` | `""` | no |
| <a name="input_connector_class_name"></a> [connector\_class\_name](#input\_connector\_class\_name) | Glue Connection connector driver class name | `string` | `""` | no |
| <a name="input_connector_file_name"></a> [connector\_file\_name](#input\_connector\_file\_name) | Connector driver file name | `string` | `null` | no |
| <a name="input_connector_file_path"></a> [connector\_file\_path](#input\_connector\_file\_path) | Path to connector driver file in S3 bucket | `string` | `null` | no |
| <a name="input_connector_url"></a> [connector\_url](#input\_connector\_url) | Glue Connection connector driver URL in S3 bucket | `string` | `""` | no |
| <a name="input_custom_connection_type"></a> [custom\_connection\_type](#input\_custom\_connection\_type) | Glue Connection type for CUSTOM connection type | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | Glue Connection description | `string` | n/a | yes |
| <a name="input_jdbc_connection_url"></a> [jdbc\_connection\_url](#input\_jdbc\_connection\_url) | Glue Connection JDBC connection URL | `string` | `""` | no |
| <a name="input_jdbc_enforce_ssl"></a> [jdbc\_enforce\_ssl](#input\_jdbc\_enforce\_ssl) | Glue Connection JDBC enforce SSL | `string` | `false` | no |
| <a name="input_match_criteria"></a> [match\_criteria](#input\_match\_criteria) | Glue Connection match criteria | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Glue Connection name | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | Glue Connection password | `string` | `""` | no |
| <a name="input_s3_acl"></a> [s3\_acl](#input\_s3\_acl) | S3 bucket ACL | `string` | `"private"` | no |
| <a name="input_s3_bucket_drivers_name"></a> [s3\_bucket\_drivers\_name](#input\_s3\_bucket\_drivers\_name) | S3 bucket name to store AWS Glue connection drivers, suffix when s3\_create\_bucket\_drivers is true | `string` | `null` | no |
| <a name="input_s3_create_bucket_drivers"></a> [s3\_create\_bucket\_drivers](#input\_s3\_create\_bucket\_drivers) | Create S3 bucket to store AWS Glue connection drivers | `bool` | `false` | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | Glue Connection secret name | `string` | `""` | no |
| <a name="input_security_group_id_list"></a> [security\_group\_id\_list](#input\_security\_group\_id\_list) | Glue Connection VPC Security Group ID list | `list(string)` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Glue Connection VPC Subnet ID | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags of resources to add | <pre>object({<br>    project     = string<br>    product     = string<br>    terraform   = string<br>    environment = string<br>    samtemplate = string<br>  })</pre> | <pre>{<br>  "environment": null,<br>  "product": null,<br>  "project": null,<br>  "samtemplate": null,<br>  "terraform": null<br>}</pre> | no |
| <a name="input_username"></a> [username](#input\_username) | Glue Connection username | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_glue_connection"></a> [glue\_connection](#output\_glue\_connection) | Glue connection |
| <a name="output_s3_object_driver"></a> [s3\_object\_driver](#output\_s3\_object\_driver) | S3 object of Glue driver |