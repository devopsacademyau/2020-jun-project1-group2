
# Description

Amazon Elastic Container Registry (Amazon ECR) is a managed AWS Docker registry service. It supports private Docker repositories with resource-based permissions using AWS IAM so that specific users or Amazon EC2 instances can access repositories and images

# Inputs

Name                   | Description                                                                                     | Type           | Default           | Required
---------------------- | ----------------------------------------------------------------------------------------------- | -------------- | ----------------- | :------:
ecr_name               | Name of the ECR repository                                                                      | `string`       | `"wordpress-ecr"` |   yes
image_tag_mutability   | The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`         | `string`       | `"MUTABLE"`       |    no
principals_full_access | Principal ARNs to provide with full access to the ECR                                           | `list(string)` | `[]`              |    no
scan_images_on_push    | Indicates whether images are scanned after being pushed to the repository (true) or not (false) | `bool`         | `false`           |   yes

# Outputs

Name            | Description
--------------- | --------------------------
repository_arn  | ARN of repository created
repository_name | Name of repository created
repository_url  | URL of repository created

# Usage

1. Retrieve an authentication token and authenticate your Docker client to your registry.[ECR is a private registry]

```
aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin ACCOUNT_ID.dkr.ecr.AWS_REGION.amazonaws.com
```

2. Build your image.

3. Tag your image to push the image to this repository.

```
docker tag IMAGE_NAME:latest ACCOUNT_ID.dkr.ecr.AWS_REGION.amazonaws.com/IMAGE_NAME:latest
```

4. Push this image to your ECR repository.

```
docker push ACCOUNT_ID.dkr.ecr.AWS_REGION.amazonaws.com/IMAGE_NAME:latest
```

5. Aditionally, to pull images from ECR repository.

```
docker pull ACCOUNT_ID.dkr.ecr.AWS_REGION.amazonaws.com/IMAGE_NAME:latest
```
=======
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

