# Module: AWS LAMBDA FUNCTION

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
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_function"></a> [lambda\_function](#module\_lambda\_function) | terraform-aws-modules/lambda/aws | 7.21.1 |
| <a name="module_lambda_layers"></a> [lambda\_layers](#module\_lambda\_layers) | terraform-aws-modules/lambda/aws | 7.21.1 |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.source_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.source_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_ownership_controls.source_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.source_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.source_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [random_string.bucket_suffix](https://registry.terraform.io/providers/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_secretsmanager_secret.datadog_apikey](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_datadog_layer"></a> [add\_datadog\_layer](#input\_add\_datadog\_layer) | Enable Datadog layer | `bool` | `false` | no |
| <a name="input_add_secrets_layer"></a> [add\_secrets\_layer](#input\_add\_secrets\_layer) | Enable AWS secrets layer | `bool` | `false` | no |
| <a name="input_allowed_triggers"></a> [allowed\_triggers](#input\_allowed\_triggers) | Allowed triggers to add the lambda | `any` | `{}` | no |
| <a name="input_lambdas_permissions"></a> [lambdas\_permissions](#input\_lambdas\_permissions) | Permissions to add to the lambda | `any` | `{}` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Lamba parameters to be passed to the module. The function\_name should be converted to <tags.product>-<tags.environment>-<tags.project>-<value\_of\_function\_name> | `any` | <pre>{<br/>  "allowed_triggers": {},<br/>  "build_in_docker": false,<br/>  "create_sam_metadata": false,<br/>  "docker_image": "",<br/>  "function_name": "",<br/>  "handler": "",<br/>  "publish": false,<br/>  "runtime": "",<br/>  "source_path": null,<br/>  "timeout": 3<br/>}</pre> | no |
| <a name="input_policy_statements"></a> [policy\_statements](#input\_policy\_statements) | Policies statetements with permissions to add to the lambda function role | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags of resources to add | <pre>object({<br/>    project     = string<br/>    product     = string<br/>    terraform   = string<br/>    environment = string<br/>    samtemplate = string<br/>  })</pre> | <pre>{<br/>  "environment": null,<br/>  "product": null,<br/>  "project": null,<br/>  "samtemplate": null,<br/>  "terraform": null<br/>}</pre> | no |
| <a name="input_version_lambda"></a> [version\_lambda](#input\_version\_lambda) | Version of lambada function | `string` | `"0.0.1"` | no |
| <a name="input_version_lambda_suffix"></a> [version\_lambda\_suffix](#input\_version\_lambda\_suffix) | Suffix to add in version of lambada function | `string` | `""` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | Vpc security group id for lambda functions | `list(string)` | `null` | no |
| <a name="input_vpc_subnet_ids"></a> [vpc\_subnet\_ids](#input\_vpc\_subnet\_ids) | Vpc subnet id for lambda functions | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_cloudwatch_log_group_arn"></a> [lambda\_cloudwatch\_log\_group\_arn](#output\_lambda\_cloudwatch\_log\_group\_arn) | The ARN of the Cloudwatch Log Group |
| <a name="output_lambda_cloudwatch_log_group_name"></a> [lambda\_cloudwatch\_log\_group\_name](#output\_lambda\_cloudwatch\_log\_group\_name) | The name of the Cloudwatch Log Group |
| <a name="output_lambda_event_source_mapping_function_arn"></a> [lambda\_event\_source\_mapping\_function\_arn](#output\_lambda\_event\_source\_mapping\_function\_arn) | The the ARN of the Lambda function the event source mapping is sending events to |
| <a name="output_lambda_event_source_mapping_state"></a> [lambda\_event\_source\_mapping\_state](#output\_lambda\_event\_source\_mapping\_state) | The state of the event source mapping |
| <a name="output_lambda_event_source_mapping_state_transition_reason"></a> [lambda\_event\_source\_mapping\_state\_transition\_reason](#output\_lambda\_event\_source\_mapping\_state\_transition\_reason) | The reason the event source mapping is in its current state |
| <a name="output_lambda_event_source_mapping_uuid"></a> [lambda\_event\_source\_mapping\_uuid](#output\_lambda\_event\_source\_mapping\_uuid) | The UUID of the created event source mapping |
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | The ARN of the Lambda Function |
| <a name="output_lambda_function_arn_static"></a> [lambda\_function\_arn\_static](#output\_lambda\_function\_arn\_static) | The static ARN of the Lambda Function. Use this to avoid cycle errors between resources (e.g., Step Functions) |
| <a name="output_lambda_function_invoke_arn"></a> [lambda\_function\_invoke\_arn](#output\_lambda\_function\_invoke\_arn) | The Invoke ARN of the Lambda Function |
| <a name="output_lambda_function_kms_key_arn"></a> [lambda\_function\_kms\_key\_arn](#output\_lambda\_function\_kms\_key\_arn) | The ARN for the KMS encryption key of Lambda Function |
| <a name="output_lambda_function_last_modified"></a> [lambda\_function\_last\_modified](#output\_lambda\_function\_last\_modified) | The date Lambda Function resource was last modified |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | The name of the Lambda Function |
| <a name="output_lambda_function_qualified_arn"></a> [lambda\_function\_qualified\_arn](#output\_lambda\_function\_qualified\_arn) | The ARN identifying your Lambda Function Version |
| <a name="output_lambda_function_qualified_invoke_arn"></a> [lambda\_function\_qualified\_invoke\_arn](#output\_lambda\_function\_qualified\_invoke\_arn) | The Invoke ARN identifying your Lambda Function Version |
| <a name="output_lambda_function_signing_job_arn"></a> [lambda\_function\_signing\_job\_arn](#output\_lambda\_function\_signing\_job\_arn) | ARN of the signing job |
| <a name="output_lambda_function_signing_profile_version_arn"></a> [lambda\_function\_signing\_profile\_version\_arn](#output\_lambda\_function\_signing\_profile\_version\_arn) | ARN of the signing profile version |
| <a name="output_lambda_function_source_code_hash"></a> [lambda\_function\_source\_code\_hash](#output\_lambda\_function\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the zip file |
| <a name="output_lambda_function_source_code_size"></a> [lambda\_function\_source\_code\_size](#output\_lambda\_function\_source\_code\_size) | The size in bytes of the function .zip file |
| <a name="output_lambda_function_url"></a> [lambda\_function\_url](#output\_lambda\_function\_url) | The URL of the Lambda Function URL |
| <a name="output_lambda_function_url_id"></a> [lambda\_function\_url\_id](#output\_lambda\_function\_url\_id) | The Lambda Function URL generated id |
| <a name="output_lambda_function_version"></a> [lambda\_function\_version](#output\_lambda\_function\_version) | Latest published version of Lambda Function |
| <a name="output_lambda_layer_arn"></a> [lambda\_layer\_arn](#output\_lambda\_layer\_arn) | The ARN of the Lambda Layer with version |
| <a name="output_lambda_layer_created_date"></a> [lambda\_layer\_created\_date](#output\_lambda\_layer\_created\_date) | The date Lambda Layer resource was created |
| <a name="output_lambda_layer_layer_arn"></a> [lambda\_layer\_layer\_arn](#output\_lambda\_layer\_layer\_arn) | The ARN of the Lambda Layer without version |
| <a name="output_lambda_layer_source_code_size"></a> [lambda\_layer\_source\_code\_size](#output\_lambda\_layer\_source\_code\_size) | The size in bytes of the Lambda Layer .zip file |
| <a name="output_lambda_layer_version"></a> [lambda\_layer\_version](#output\_lambda\_layer\_version) | The Lambda Layer version |
| <a name="output_lambda_role_arn"></a> [lambda\_role\_arn](#output\_lambda\_role\_arn) | The ARN of the IAM role created for the Lambda Function |
| <a name="output_lambda_role_name"></a> [lambda\_role\_name](#output\_lambda\_role\_name) | The name of the IAM role created for the Lambda Function |
| <a name="output_lambda_role_unique_id"></a> [lambda\_role\_unique\_id](#output\_lambda\_role\_unique\_id) | The unique id of the IAM role created for the Lambda Function |
| <a name="output_local_filename"></a> [local\_filename](#output\_local\_filename) | The filename of zip archive deployed (if deployment was from local) |
| <a name="output_s3_object"></a> [s3\_object](#output\_s3\_object) | The map with S3 object data of zip archive deployed (if deployment was from S3) |