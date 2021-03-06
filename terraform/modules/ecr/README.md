# Description

Amazon Elastic Container Registry (Amazon ECR) is a managed AWS Docker registry service. It supports private Docker repositories with resource-based permissions using AWS IAM so that specific users or Amazon EC2 instances can access repositories and images

# Inputs

Name                   | Description                                                                                     | Type           | Default           | Required
---------------------- | ----------------------------------------------------------------------------------------------- | -------------- | ----------------- | :------:
image_tag_mutability   | The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`         | `string`       | `"MUTABLE"`       |    no
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

