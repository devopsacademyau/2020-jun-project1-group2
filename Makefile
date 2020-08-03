DOCKER=docker-compose run --rm
TF_VARS=main.tfvars
TF_STATE=terraform.tfstate
TF_PLAN=wordpress.tfplan

plan: _env _env-AWS_ACCESS_KEY_ID _env-AWS_SECRET_ACCESS_KEY _init _test
	$(DOCKER) terraform plan -var-file=$(TF_VARS) -state=$(TF_STATE) -out=$(TF_PLAN)
.PHONY: plan

apply: _env _env-AWS_ACCESS_KEY_ID _env-AWS_SECRET_ACCESS_KEY _init
	$(DOCKER) terraform apply -state=$(TF_STATE) $(TF_PLAN)
.PHONY: apply

destroy: _env _env-AWS_ACCESS_KEY_ID _env-AWS_SECRET_ACCESS_KEY _init
	$(DOCKER) terraform destroy -var-file=$(TF_VARS) -state=$(TF_STATE)
.PHONY: destroy

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

