# Module: AWS API GATEWAY

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.63 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.63 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_account.api_account_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_account) | resource |
| [aws_api_gateway_account.api_account_cloudwatch_custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_account) | resource |
| [aws_api_gateway_rest_api.api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_cloudwatch_log_group.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.api_account_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.api_account_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_policy_document.api_account_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.api_account_cloudwatch_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_cloudwatch_role_arn"></a> [custom\_cloudwatch\_role\_arn](#input\_custom\_cloudwatch\_role\_arn) | Custom CloudWatch role ARN | `string` | `null` | no |
| <a name="input_enable_cloudwatch_role"></a> [enable\_cloudwatch\_role](#input\_enable\_cloudwatch\_role) | Enable CloudWatch role in API Gateway setings account | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | API Gateway name | `string` | `"default"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags of resources to add | <pre>object({<br>    project     = string<br>    product     = string<br>    terraform   = string<br>    environment = string<br>  })</pre> | <pre>{<br>  "environment": null,<br>  "product": null,<br>  "project": null,<br>  "terraform": null<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Attributie ARN of the API Gateway |
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | Attributie ARN of CloudWatch log group |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | Attributie Name of CloudWatch log group |
| <a name="output_cloudwatch_log_group_tags_all"></a> [cloudwatch\_log\_group\_tags\_all](#output\_cloudwatch\_log\_group\_tags\_all) | A map of tags assigned to the CloudWatch log group, including those inherited from the provider default\_tags configuration block |
| <a name="output_created_date"></a> [created\_date](#output\_created\_date) | Attributie created date of the API Gateway |
| <a name="output_execution_arn"></a> [execution\_arn](#output\_execution\_arn) | Attributie execution ARN of the API Gateway |
| <a name="output_id"></a> [id](#output\_id) | Attributie identifier of the API Gateway |
| <a name="output_root_resource_id"></a> [root\_resource\_id](#output\_root\_resource\_id) | Attributie root resource id of the API Gateway |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the API Gateway, including those inherited from the provider default\_tags configuration block |