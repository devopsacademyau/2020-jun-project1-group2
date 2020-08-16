DOCKER=docker-compose run --rm
TF_VARS=wordpress.tfvars
TF_PLAN=wordpress.tfplan

plan: _env _env-AWS_ACCESS_KEY_ID _env-AWS_SECRET_ACCESS_KEY _env-TF_VAR_container_image_uri _init _test
	$(DOCKER) terraform plan -var-file=$(TF_VARS) -out=$(TF_PLAN)
.PHONY: plan

apply: _env _env-AWS_ACCESS_KEY_ID _env-AWS_SECRET_ACCESS_KEY _env-TF_VAR_container_image_uri _init
	$(DOCKER) terraform apply $(TF_PLAN)
.PHONY: apply

destroy: _env _env-AWS_ACCESS_KEY_ID _env-AWS_SECRET_ACCESS_KEY _env-TF_VAR_container_image_uri _init
	$(DOCKER) terraform destroy -var-file=$(TF_VARS)
.PHONY: destroy

build: _env _env-AWS_ACCESS_KEY_ID _env-AWS_SECRET_ACCESS_KEY
	$(eval AWS_ID=$(shell aws sts get-caller-identity --query Account --output text | head -n 1 | tr -d '\r\n'))
	$(eval GIT_SHA=$(shell git rev-parse --short HEAD ))
	aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin $(AWS_ID).dkr.ecr.ap-southeast-2.amazonaws.com ;\
	docker build -f docker/wordpress-image/Dockerfile -t wordpress-ecr . ;\
	docker tag wordpress-ecr $(AWS_ID).dkr.ecr.ap-southeast-2.amazonaws.com/wordpress-ecr:$(GIT_SHA)
PHONY: build

publish: _env _env-AWS_ACCESS_KEY_ID _env-AWS_SECRET_ACCESS_KEY
	$(eval AWS_ID=$(shell aws sts get-caller-identity --query Account --output text | head -n 1 | tr -d '\r\n'))
	$(eval GIT_SHA=$(shell git rev-parse --short HEAD ))
	docker push $(AWS_ID).dkr.ecr.ap-southeast-2.amazonaws.com/wordpress-ecr:$(GIT_SHA)
PHONY: publish

deploy-wp: _env _env-AWS_ACCESS_KEY_ID _env-AWS_SECRET_ACCESS_KEY
	$(eval AWS_ID=$(shell aws sts get-caller-identity --query Account --output text | head -n 1 | tr -d '\r\n'))
	$(eval GIT_SHA=$(shell git rev-parse --short HEAD ))
	$(DOCKER) -e TF_VAR_container_image_uri=$(AWS_ID).dkr.ecr.ap-southeast-2.amazonaws.com/wordpress-ecr:$(GIT_SHA) terraform init ;\
	$(DOCKER) -e TF_VAR_container_image_uri=$(AWS_ID).dkr.ecr.ap-southeast-2.amazonaws.com/wordpress-ecr:$(GIT_SHA) terraform plan -var-file=$(TF_VARS) -out=$(TF_PLAN)
	$(DOCKER) -e TF_VAR_container_image_uri=$(AWS_ID).dkr.ecr.ap-southeast-2.amazonaws.com/wordpress-ecr:$(GIT_SHA) terraform apply $(TF_PLAN)
PHONY: deploy-wp

_env:
	cp .env-template .env
PHONY: _env

_env-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "ERROR environment varaible: $* must be set."; \
		exit 1; \
	fi

_init:
	$(DOCKER) terraform init
.PHONY: _init

_test: _env
	$(DOCKER) tflint
.PHONY: test

