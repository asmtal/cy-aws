.DEFAULT_GOAL := plan

setup:
	@AWS_ACCOUNT_NAME=$$(echo $(project) | cut -d '/' -f1) && \
	  cp -r _shared/_all/* $(project)/ && \
	  cp -r _shared/$${AWS_ACCOUNT_NAME}/* $(project)/

clean:
	@git clean -ffdX

init: setup
	@cd $(project) && (test -d .terraform || terraform init -backend-config key=$(project)/terraform.tfstate)

initf: setup
	@cd $(project) && terraform init -backend-config key=$(project)/terraform.tfstate

plan: init
	@cd $(project) && terraform plan -var project=$(project) -out plan.out

apply: init
	@cd $(project) && terraform apply plan.out

applya: init
	@cd $(project) && terraform apply -var project=$(project) -auto-approve

terraform:
	@cd $(project) && terraform $(cmd)

terraformv:
	@cd $(project) && terraform -var project=$(project) $(cmd)
