# Module: AWS S3 NOTIFICATIONS

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
| [aws_s3_bucket_notification.bucket_event](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_s3_bucket_notification.bucket_event_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_sns_topic.s3_object_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sns_topic) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | S3 Bucket ID | `string` | n/a | yes |
| <a name="input_lambda_notifications"></a> [lambda\_notifications](#input\_lambda\_notifications) | values for bucket notifications | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags of resources to add | <pre>object({<br/>    project     = string<br/>    product     = string<br/>    terraform   = string<br/>    environment = string<br/>    samtemplate = string<br/>  })</pre> | <pre>{<br/>  "environment": null,<br/>  "product": null,<br/>  "project": null,<br/>  "samtemplate": null,<br/>  "terraform": null<br/>}</pre> | no |

## Outputs

No outputs.