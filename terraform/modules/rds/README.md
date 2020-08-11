## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| rds\_cluster\_name | RDS cluster name | `string` | n/a | yes |
| rds\_database\_name | Database name, Eg. wordpress | `string` | n/a | yes |
| rds\_database\_password | Database password to connect to DB | `string` | n/a | yes |
| rds\_database\_user | Database username to connect to DB | `string` | n/a | yes |
| rds\_engine | RDS engine, eg. aurora | `string` | `"aurora"` | no |
| rds\_engine\_mode | RDS engine mode, eg. serverless | `string` | `"serverless"` | no |
| rds\_security\_group\_ids | Security groups to associate with RDS | `list` | n/a | yes |
| rds\_subnet\_ids | Subnet ids to associate the RDS instance to | `list` | n/a | yes |

## Outputs

No output.

