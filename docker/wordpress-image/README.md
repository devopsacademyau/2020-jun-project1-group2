# Wordpress Docker Image
This folder contains the base Wordpress Docker configuration, to be used for building container images for the `2020-jun-project1-group2` project.

The following document describes how to build and tag versions of the image; as well as how to push it to the project's AWS ECR repository.

## Building the Wordpress image
The [Dockerfile](Dockerfile) contains the configuration for building the image. 

Builds are based upon the [Dockerhub Wordpress Repository](https://hub.docker.com/_/wordpress/) and are locked to a particular version; as defined in the Dockerfile.

The image build process uses the `make` command to trigger the `build` actions defined in the [Makefile](Makefile)

The following commands will trigger a new build of the image:

1. Clone this repository with the following commands:
```
$ git clone git@github.com:devopsacademyau/2020-jun-project1-group2.git
$ cd 2020-jun-project1-group2
```
2. Execute the following make command to start the docker build process. 
Note: be sure to set the REPO_URL variable to the correct ECR repository URL.

```
$ REPO_URL=ecr.repo.url make build
```
3. The build process completes and generates a new image. 
A version tag of the current Git short SHA will be automatically added to the image.

## Pushing the built image to AWS ECR
The following process will push the built image to ECR. 
Note: The host performing the process must have access to the AWS ECR repository - for instance, an EC2 host with defined access.

1. Run the following command to push the built image (from the build stage above) to the ECR repository:
```
$ make push
```

The image will now be available for use within ECR, via the Git SHA tag produced above.


