## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| wordpress\_db\_host | RDS database endpoint URL for connecting to the Wordpress database. | `string` | n/a | yes |
| wordpress\_db\_name | Name of the RDS database used to hold the Wordpress data | `string` | `"wordpress"` | no |
| wordpress\_db\_user | Database username for establishing a connection to the Wordpress database | `string` | `"wordpress"` | no |

## Outputs

| Name | Description |
|------|-------------|
| wordpress\_db\_host | Wordpress RDS endpoint url |
| wordpress\_db\_name | Wordpress RDS database name |
| wordpress\_db\_password | Wordpress RDS database password |
| wordpress\_db\_user | Wordpress RDS database user |

