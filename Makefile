setup:
	@AWS_ACCOUNT_NAME=$$(echo $(project) | cut -d '/' -f1) && \
	  cp -r _shared/_all/* $(project)/ && \
	  cp -r _shared/$${AWS_ACCOUNT_NAME}/* $(project)/

clean:
	@git clean -ffdx

init: setup
	@cd $(project) && (test -d .terraform || terraform init -backend-config key=$(project)/terraform.tfstate)

initf: setup
	@cd $(project) && terraform init -backend-config key=$(project)/terraform.tfstate

plan: init
	@cd $(project) && terraform plan -var project=$(project) -out plan.out

apply: init
	@cd $(project) && terraform apply plan.out

terraform:
	@cd $(project) && terraform $(cmd)

terraformv:
	@cd $(project) && terraform -var project=$(project) $(cmd)
