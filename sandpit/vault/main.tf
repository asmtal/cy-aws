module "public_ip" {
  source = "../../_modules/public_ip"
}

data "terraform_remote_state" "dns" {
  backend = "s3"

  config = {
    bucket = "cy-terraform"
    key    = "sandpit/dns/terraform.tfstate"
    region = "ap-southeast-2"
  }
}

data "terraform_remote_state" "monitoring" {
  backend = "s3"

  config = {
    bucket = "cy-terraform"
    key    = "sandpit/monitoring/terraform.tfstate"
    region = "ap-southeast-2"
  }
}

data "terraform_remote_state" "consul" {
  backend = "s3"

  config = {
    bucket = "cy-terraform"
    key    = "sandpit/consul/terraform.tfstate"
    region = "ap-southeast-2"
  }
}

module "vault" {
  source = "../../_modules/vault"

  vpc_id       = data.terraform_remote_state.accounts.outputs.sandpit.default_vpc_id
  outbound_ip  = module.public_ip.ip
  ssh_key_name = aws_key_pair.personal.key_name

  hostname        = "vault.${var.environment}.yaameh.com"
  route53_zone_id = data.terraform_remote_state.dns.outputs.route53_zone.zone_id

  promtail_address = data.terraform_remote_state.monitoring.outputs.loki.promtail_address

  consul_cluster_id = data.terraform_remote_state.consul.outputs.consul.consul_cluster_id
}

output "vault" {
  value = module.vault
}
