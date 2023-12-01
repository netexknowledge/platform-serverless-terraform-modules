# Module: AWS SNS

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
| [aws_sns_topic.user_updates](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_content_based_deduplication"></a> [content\_based\_deduplication](#input\_content\_based\_deduplication) | Whether the SNS topic is content based deduplication | `bool` | `false` | no |
| <a name="input_delivery_policy"></a> [delivery\_policy](#input\_delivery\_policy) | The SNS delivery policy | `string` | `null` | no |
| <a name="input_fifo_topic"></a> [fifo\_topic](#input\_fifo\_topic) | Whether the SNS topic is FIFO | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | name of the SNS topic | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags of resources to add | <pre>object({<br>    project     = string<br>    product     = string<br>    terraform   = string<br>    environment = string<br>    samtemplate = string<br>  })</pre> | <pre>{<br>  "environment": null,<br>  "product": null,<br>  "project": null,<br>  "samtemplate": null,<br>  "terraform": null<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_topic_arn"></a> [topic\_arn](#output\_topic\_arn) | value of SNS topic arn |
| <a name="output_topic_id"></a> [topic\_id](#output\_topic\_id) | value of SNS topic id |