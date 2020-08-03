IMAGE_NAME ?= wordpress
VERSION := $(shell git rev-parse --short HEAD)
REPO_URL ?= todo

build:
	docker build -t $(REPO_URL)/$(IMAGE_NAME):$(VERSION) .
PHONY: build

push:
	docker push $(REPO_URL)/$(IMAGE_NAME):$(VERSION)
PHONY: push

