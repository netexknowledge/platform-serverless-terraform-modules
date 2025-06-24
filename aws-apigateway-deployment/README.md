# Module: AWS API GATEWAY

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
| [aws_api_gateway_base_path_mapping.custom_mapping](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_base_path_mapping) | resource |
| [aws_api_gateway_deployment.deployment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_method_settings.deployment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_settings) | resource |
| [aws_api_gateway_stage.stage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage) | resource |
| [aws_apigatewayv2_api_mapping.custom_mapping](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api_mapping) | resource |
| [aws_apigatewayv2_deployment.deployment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_deployment) | resource |
| [aws_apigatewayv2_stage.stage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage) | resource |
| [aws_wafv2_web_acl_association.waf_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_waf_web_acl.ApiGatewayACL](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/waf_web_acl) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_id"></a> [api\_id](#input\_api\_id) | API Gateway ID | `string` | `""` | no |
| <a name="input_base_path"></a> [base\_path](#input\_base\_path) | Name concatenated by project and api name. | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#input\_cloudwatch\_log\_group\_arn) | ARN of CloudWatch log group | `string` | `null` | no |
| <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain) | Indicates whether to create a custom domain for the API. | `bool` | `false` | no |
| <a name="input_custom_domain_name"></a> [custom\_domain\_name](#input\_custom\_domain\_name) | Name of the custom domain. | `string` | `null` | no |
| <a name="input_enable_cloudwatch_role"></a> [enable\_cloudwatch\_role](#input\_enable\_cloudwatch\_role) | Enable CloudWatch role in API Gateway setings account | `bool` | `false` | no |
| <a name="input_stage_name"></a> [stage\_name](#input\_stage\_name) | Name of API Gateway deployment stage | `string` | `"$default"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags of resources to add | <pre>object({<br/>    project     = string<br/>    product     = string<br/>    terraform   = string<br/>    environment = string<br/>    samtemplate = string<br/>  })</pre> | <pre>{<br/>  "environment": null,<br/>  "product": null,<br/>  "project": null,<br/>  "samtemplate": null,<br/>  "terraform": null<br/>}</pre> | no |
| <a name="input_triggers"></a> [triggers](#input\_triggers) | Object of triggers of API Gateway deployment | `any` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | API Gateway type | `string` | `"REST"` | no |
| <a name="input_waf_web_acl_name"></a> [waf\_web\_acl\_name](#input\_waf\_web\_acl\_name) | Name of the WAF web ACL. | `string` | `"SecurityACL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the API Gateway |
| <a name="output_invoke_url"></a> [invoke\_url](#output\_invoke\_url) | Attribute invoke URL of the API Gateway |