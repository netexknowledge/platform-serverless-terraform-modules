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
| [aws_api_gateway_authorizer.authorizer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_authorizer) | resource |
| [aws_apigatewayv2_authorizer.authorizer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_authorizer) | resource |
| [aws_iam_role.invocation_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.invocation_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_policy_document.invocation_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.invocation_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_id"></a> [api\_id](#input\_api\_id) | API Gateway ID | `string` | `""` | no |
| <a name="input_api_name"></a> [api\_name](#input\_api\_name) | API Gateway name | `string` | `""` | no |
| <a name="input_lambda_function_arn"></a> [lambda\_function\_arn](#input\_lambda\_function\_arn) | Lambda function arn | `string` | `null` | no |
| <a name="input_lambda_function_invoke_arn"></a> [lambda\_function\_invoke\_arn](#input\_lambda\_function\_invoke\_arn) | Lambda function invoke arn | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of API Gateway Authorizer | `string` | `"authorizer"` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | API Gateway Authorizer parameters to be passed to the module | `any` | <pre>{<br>  "authorizer_result_ttl_in_seconds": 0,<br>  "identity_source": "method.request.header.Authorization",<br>  "lambda_name": "authorizer"<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags of resources to add | <pre>object({<br>    project     = string<br>    product     = string<br>    terraform   = string<br>    environment = string<br>    samtemplate = string<br>  })</pre> | <pre>{<br>  "environment": null,<br>  "product": null,<br>  "project": null,<br>  "samtemplate": null,<br>  "terraform": null<br>}</pre> | no |
| <a name="input_type"></a> [type](#input\_type) | API Gateway type | `string` | `"REST"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Attributie ARN of the API Gateway Authorizer |
| <a name="output_id"></a> [id](#output\_id) | Attributie Authorizer identifier |