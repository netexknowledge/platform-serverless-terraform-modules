# Module: AWS API GATEWAY

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.37 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.37 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_integration.integrations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_method.methods](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_resource.resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_resource) | resource |
| [aws_apigatewayv2_integration.integrations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_integration) | resource |
| [aws_apigatewayv2_route.methods](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_route) | resource |
| [aws_apigatewayv2_route_response.responses](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_route_response) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_gateway_authorizer_id"></a> [api\_gateway\_authorizer\_id](#input\_api\_gateway\_authorizer\_id) | API Gateway Authorizer ID | `string` | `null` | no |
| <a name="input_api_id"></a> [api\_id](#input\_api\_id) | API Gateway ID | `string` | `""` | no |
| <a name="input_api_name"></a> [api\_name](#input\_api\_name) | API Gateway name | `string` | `""` | no |
| <a name="input_api_root_resource_id"></a> [api\_root\_resource\_id](#input\_api\_root\_resource\_id) | API Gateway root resource id | `string` | `""` | no |
| <a name="input_authorizer_id"></a> [authorizer\_id](#input\_authorizer\_id) | API Gateway Authorizer ID pre-existing | `string` | `null` | no |
| <a name="input_lambda_function_invoke_arn"></a> [lambda\_function\_invoke\_arn](#input\_lambda\_function\_invoke\_arn) | Lambda function invoke arn | `string` | `null` | no |
| <a name="input_lambda_function_invoke_arns_by_method"></a> [lambda\_function\_invoke\_arns\_by\_method](#input\_lambda\_function\_invoke\_arns\_by\_method) | List of Lambda function invoke arn by method | `any` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of API Gateway Resource | `string` | `"authorizer"` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | API Gateway Resource parameters to be passed to the module | `any` | <pre>{<br>  "authorizer": null,<br>  "authorizer_id": null,<br>  "http_method": [<br>    "ANY"<br>  ]<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags of resources to add | <pre>object({<br>    project     = string<br>    product     = string<br>    terraform   = string<br>    environment = string<br>    samtemplate = string<br>  })</pre> | <pre>{<br>  "environment": null,<br>  "product": null,<br>  "project": null,<br>  "samtemplate": null,<br>  "terraform": null<br>}</pre> | no |
| <a name="input_type"></a> [type](#input\_type) | API Gateway type | `string` | `"REST"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_integrations"></a> [integrations](#output\_integrations) | API Gateway integrations |
| <a name="output_integrations_id"></a> [integrations\_id](#output\_integrations\_id) | Concatenated list of API Gateway Integration IDs |
| <a name="output_methods"></a> [methods](#output\_methods) | API Gateway methods |
| <a name="output_methods_id"></a> [methods\_id](#output\_methods\_id) | Concatenated list of API Gateway Methods IDs |
| <a name="output_resource"></a> [resource](#output\_resource) | API Gateway resource |