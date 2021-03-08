.DEFAULT_GOAL := plan

setup: guard-project
	@AWS_ACCOUNT_NAME=$$(echo $(project) | cut -d '/' -f1) && \
	  cp -r _shared/_all/* $(project)/ && \
	  cp -r _shared/$${AWS_ACCOUNT_NAME}/* $(project)/

clean:
	@git clean -ffdX

init: guard-project setup
	@cd $(project) && (test -d .terraform || terraform init -backend-config key=$(project)/terraform.tfstate)

initf: guard-project setup
	@cd $(project) && terraform init -backend-config key=$(project)/terraform.tfstate

plan: guard-project init
	@cd $(project) && terraform plan -var project=$(project) -out plan.out

pland: guard-project init
	@cd $(project) && terraform plan -var project=$(project) -out plan.out -destroy

plana: guard-environment
	@find $(environment)/ -type f -name "*.tf" -exec dirname {} \; | uniq | xargs -L1 -I{} make project={} plan

planad: guard-environment
	@find $(environment)/ -type f -name "*.tf" -exec dirname {} \; | uniq | xargs -L1 -I{} make project={} pland

apply: guard-project init
	@cd $(project) && terraform apply plan.out

applya: guard-project init
	@find $(environment)/ -type f -name "*.tf" -exec dirname {} \; | uniq | xargs -L1 -I{} make project={} apply

terraform: guard-project guard-cmd
	@cd $(project) && terraform $(cmd)

terraformv: guard-project guard-cmd
	@cd $(project) && terraform -var project=$(project) $(cmd)

guard-%:
	@if [ -z '${${*}}' ]; then echo 'Environment variable $* not set' && exit 1; fi
