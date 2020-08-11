## Requirements

No requirements.

## Providers



| Name | Version |


|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| image\_names | List of Docker local image names, used as repository names for AWS ECR | `list(string)` | `[]` | no |
| image\_tag\_mutability | The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE` | `string` | `"MUTABLE"` | no |
| principals\_full\_access | Principal ARNs to provide with full access to the ECR | `list(string)` | `[]` | no |
| principals\_readonly\_access | Principal ARNs to provide with readonly access to the ECR | `list(string)` | `[]` | no |
| region | define the aws region to deploy the resources | `string` | `"ap-southeast-2"` | no |
| scan\_images\_on\_push | Indicates whether images are scanned after being pushed to the repository (true) or not (false) | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| repository\_arn | ARN of repository created |
| repository\_name | Name of repository created |
| repository\_url | URL of repository created |

