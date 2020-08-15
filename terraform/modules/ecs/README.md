## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alb\_security\_groups | Security Groups for ALB | `list` | n/a | yes |
| alb\_subnets | Subnets for ALB | `list` | n/a | yes |
| application\_name | ECS naming prefix | `string` | n/a | yes |
| container\_definition | ECS container definition JSON | `string` | n/a | yes |
| container\_image\_uri | Application image URI. Eg. myrepo.com/myimage:version | `string` | n/a | yes |
| ecs\_security\_groups | Security Groups for ECS | `list` | n/a | yes |
| ecs\_subnets | Subnets for ECS | `list` | n/a | yes |
| efs\_access\_point\_id | EFS Access Point identifier | `string` | n/a | yes |
| efs\_file\_system\_id | EFS filesystem identifier | `string` | n/a | yes |
| task\_role\_arn | IAM role ARN used to perform ECS tasks | `string` | n/a | yes |
| vpc\_id | VPC for ECS and ALB | `string` | n/a | yes |

## Outputs

No output.