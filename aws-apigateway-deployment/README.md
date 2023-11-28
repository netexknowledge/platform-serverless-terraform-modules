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
| [aws_api_gateway_deployment.deployment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_stage.stage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_id"></a> [api\_id](#input\_api\_id) | API Gateway ID | `string` | `""` | no |
| <a name="input_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#input\_cloudwatch\_log\_group\_arn) | ARN of CloudWatch log group | `string` | `null` | no |
| <a name="input_enable_cloudwatch_role"></a> [enable\_cloudwatch\_role](#input\_enable\_cloudwatch\_role) | Enable CloudWatch role in API Gateway setings account | `bool` | `false` | no |
| <a name="input_stage_name"></a> [stage\_name](#input\_stage\_name) | Name of API Gateway deployment stage | `string` | `"default"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags of resources to add | <pre>object({<br>    project     = string<br>    product     = string<br>    terraform   = string<br>    environment = string<br>  })</pre> | <pre>{<br>  "environment": null,<br>  "product": null,<br>  "project": null,<br>  "terraform": null<br>}</pre> | no |
| <a name="input_triggers"></a> [triggers](#input\_triggers) | Object of triggers of API Gateway deployment | `any` | `{}` | no |

## Outputs

No outputs.