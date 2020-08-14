IMAGE_NAME ?= wordpress
VERSION := $(shell git rev-parse --short HEAD)
#REPO_URL ?= todo
AWS_REGION = $(shell aws configure get region --output text) 
ACCOUNT_ID = $(shell aws sts get-caller-identity --query 'Account' --output text)
REGISTRY_URL = $(ACCOUNT_ID).dkr.ecr.ap-southeast-2.amazonaws.com
ECR_URI = $(TF_VAR_container_image_uri)

ecr-login: 
	aws ecr get-login-password --region $(AWS_REGION) \
	| docker login --username AWS --password-stdin $(REGISTRY_URL)

build:
	docker build -t $(REPO_URL)/$(IMAGE_NAME):$(VERSION) .
PHONY: build

push:
	docker push $(REPO_URL)/$(IMAGE_NAME):$(VERSION)
PHONY: push

