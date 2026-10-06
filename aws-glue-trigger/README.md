# Module: AWS Glue Trigger

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
| [aws_glue_trigger.trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_trigger) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions"></a> [actions](#input\_actions) | Glue Trigger actions of job | `any` | <pre>{<br>  "arguments": null,<br>  "job_name": null,<br>  "notify_delay_after": null,<br>  "security_configuration": null,<br>  "timeout": null<br>}</pre> | no |
| <a name="input_description"></a> [description](#input\_description) | Glue Trigger description | `string` | `""` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Glue Trigger | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Glue Trigger name | `string` | n/a | yes |
| <a name="input_predicate"></a> [predicate](#input\_predicate) | Glue Trigger predicate of job state | `any` | <pre>{<br>  "job_name": null,<br>  "logical_operator": null,<br>  "state": null<br>}</pre> | no |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | Glue Crawler Schedule | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags of resources to add | <pre>object({<br>    project     = string<br>    product     = string<br>    terraform   = string<br>    environment = string<br>    samtemplate = string<br>  })</pre> | <pre>{<br>  "environment": null,<br>  "product": null,<br>  "project": null,<br>  "samtemplate": null,<br>  "terraform": null<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_trigger"></a> [trigger](#output\_trigger) | Glue Trigger |