# Module: AWS Glue Job

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
| [aws_glue_job.job](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_job) | resource |
| [aws_iam_policy.glue_s3_bucket_created_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.glue_s3_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.glue_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.glue_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.glue_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.glue_s3_bucket_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket.glue_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.glue_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_ownership_controls.glue_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.glue_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.glue_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_object.glue_bucket_path](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [random_string.bucket_suffix](https://registry.terraform.io/providers/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_scale_within_microbatch"></a> [auto\_scale\_within\_microbatch](#input\_auto\_scale\_within\_microbatch) | Auto scale within microbatch. Dafault is false | `string` | `"false"` | no |
| <a name="input_connections"></a> [connections](#input\_connections) | Glue job connections list | `list(string)` | n/a | yes |
| <a name="input_custom_script_location_object_key"></a> [custom\_script\_location\_object\_key](#input\_custom\_script\_location\_object\_key) | S3 bucket storage for Glue job custom script location object key | `string` | `""` | no |
| <a name="input_enable_continuous_cloudwatch_log"></a> [enable\_continuous\_cloudwatch\_log](#input\_enable\_continuous\_cloudwatch\_log) | Enable continuous CloudWatch log. Default is true | `string` | `"true"` | no |
| <a name="input_enable_continuous_log_filter"></a> [enable\_continuous\_log\_filter](#input\_enable\_continuous\_log\_filter) | Enable continuous log filter. Default is true | `string` | `"true"` | no |
| <a name="input_enable_continuous_log_log_group"></a> [enable\_continuous\_log\_log\_group](#input\_enable\_continuous\_log\_log\_group) | Enable continuous log log group | `string` | `""` | no |
| <a name="input_enable_continuous_log_start_pattern"></a> [enable\_continuous\_log\_start\_pattern](#input\_enable\_continuous\_log\_start\_pattern) | Enable continuous log start pattern. Default is LOG | `string` | `"LOG"` | no |
| <a name="input_enable_continuous_log_stream_name"></a> [enable\_continuous\_log\_stream\_name](#input\_enable\_continuous\_log\_stream\_name) | Enable continuous log stream name | `string` | `""` | no |
| <a name="input_enable_glue_datacatalog"></a> [enable\_glue\_datacatalog](#input\_enable\_glue\_datacatalog) | Enable Glue data catalog. Default is true | `string` | `"true"` | no |
| <a name="input_enable_job_insights"></a> [enable\_job\_insights](#input\_enable\_job\_insights) | Enable job insights. Default is true | `string` | `"true"` | no |
| <a name="input_enable_metrics"></a> [enable\_metrics](#input\_enable\_metrics) | Enable metrics. Default is true | `string` | `"true"` | no |
| <a name="input_enable_observability_metrics"></a> [enable\_observability\_metrics](#input\_enable\_observability\_metrics) | Enable observability metrics. Default is false | `string` | `"false"` | no |
| <a name="input_enable_spark_ui"></a> [enable\_spark\_ui](#input\_enable\_spark\_ui) | Enable Spark UI. Default is true | `string` | `"true"` | no |
| <a name="input_execution_class"></a> [execution\_class](#input\_execution\_class) | Glue job execution class. Valid values are STANDARD or FLEX. Default is STANDARD | `string` | `"STANDARD"` | no |
| <a name="input_glue_version"></a> [glue\_version](#input\_glue\_version) | Glue job version. Valid values are 1.0, 2.0, 3.0 and 4.0. Deafult is 3.0 | `string` | `"3.0"` | no |
| <a name="input_job_bookmark_option"></a> [job\_bookmark\_option](#input\_job\_bookmark\_option) | Job bookmark option. Valid values are job-bookmark-disable, job-bookmark-enable, job-bookmark-allow-override. Default is job-bookmark-disable | `string` | `"job-bookmark-disable"` | no |
| <a name="input_job_language"></a> [job\_language](#input\_job\_language) | The language of the job. Default is python-3 | `string` | `"python"` | no |
| <a name="input_max_concurrent_runs"></a> [max\_concurrent\_runs](#input\_max\_concurrent\_runs) | Glue job max concurrent runs. Default is 1 | `number` | `1` | no |
| <a name="input_max_retries"></a> [max\_retries](#input\_max\_retries) | Glue job max retries. Default is 0 | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | Glue Job name | `string` | n/a | yes |
| <a name="input_number_of_workers"></a> [number\_of\_workers](#input\_number\_of\_workers) | Glue job number of workers. Default is 2 | `number` | `2` | no |
| <a name="input_s3_acl"></a> [s3\_acl](#input\_s3\_acl) | S3 bucket storage for Glue job ACL | `string` | `"private"` | no |
| <a name="input_s3_bucket_glue_name"></a> [s3\_bucket\_glue\_name](#input\_s3\_bucket\_glue\_name) | S3 bucket storage name for Glue job | `string` | `null` | no |
| <a name="input_s3_create_bucket_glue"></a> [s3\_create\_bucket\_glue](#input\_s3\_create\_bucket\_glue) | Create S3 bucket storage for Glue job | `bool` | `false` | no |
| <a name="input_script_file_path"></a> [script\_file\_path](#input\_script\_file\_path) | S3 bucket storage for Glue job script file path | `string` | `null` | no |
| <a name="input_spark_event_logs_path"></a> [spark\_event\_logs\_path](#input\_spark\_event\_logs\_path) | Path to Spark event logs | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags of resources to add | <pre>object({<br>    project     = string<br>    product     = string<br>    terraform   = string<br>    environment = string<br>    samtemplate = string<br>  })</pre> | <pre>{<br>  "environment": null,<br>  "product": null,<br>  "project": null,<br>  "samtemplate": null,<br>  "terraform": null<br>}</pre> | no |
| <a name="input_temp_dir"></a> [temp\_dir](#input\_temp\_dir) | Temporary directory | `string` | `null` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Glue job timeout execution in minutes. Default is 2880 | `number` | `2880` | no |
| <a name="input_worker_type"></a> [worker\_type](#input\_worker\_type) | Glue job worker type. Valid values are Standard, G.1X, G.2X, G.025X,  Z.2X. Default is G.1X | `string` | `"G.1X"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_glue_bucket"></a> [glue\_bucket](#output\_glue\_bucket) | Glue S3 bucket |
| <a name="output_job"></a> [job](#output\_job) | Glue Job |
| <a name="output_role"></a> [role](#output\_role) | Glue Job Role |